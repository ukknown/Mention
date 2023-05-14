package com.ssafy.gatewayservice.filter;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.gatewayservice.dto.InfoDto;
import com.ssafy.gatewayservice.dto.MemberDto;
import com.ssafy.gatewayservice.dto.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.env.Environment;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Date;
import java.util.Map;

@Component
@Slf4j
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {

    Environment env;

    private final RedisTemplate redisTemplate;

    @Value("${jwt.token-validity-in-milliseconds}")
    private long accessTokenValidityTime;

    @Value("${jwt.secret}")
    private String secret_key;

    private String accessToken;

    public AuthorizationHeaderFilter(Environment env, RedisTemplate redisTemplate) {
        super(Config.class);
        this.env = env;
        this.redisTemplate = redisTemplate;
    }

    @Override
    public GatewayFilter apply(Config config) {
        return ((exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();
//            ServerHttpResponse response = exchange.getResponse();

            if(!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION)){
                return onError(exchange, "No authorization header", HttpStatus.UNAUTHORIZED);
            }

            String authorizationHeader = request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);
            String jwt = authorizationHeader.replace("Bearer","");
            System.out.println("들어오는 accesstoken : "+jwt);
            accessToken = jwt.trim();
            jwt = jwt.trim();

            System.out.println("test : " + redisTemplate.opsForValue().get(accessToken));

            if(!isJwtValid(jwt)){
                return onError(exchange, "JWT token is not valid", HttpStatus.UNAUTHORIZED);
            }

            if(!accessToken.equals(jwt)){
                System.out.println("access token 수정");
                exchange.getRequest().mutate()
                        .headers(httpHeaders -> {
                            // remove existing access token header if present
                            httpHeaders.remove(HttpHeaders.AUTHORIZATION);

                            // add new access token header
                            httpHeaders.add(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken);
                        })
                        .build();
            }

            exchange.getRequest().mutate()
                    .headers(httpHeaders -> {
                        // remove existing access token header if present
                        httpHeaders.remove(HttpHeaders.AUTHORIZATION);

                        // add new access token header
                        httpHeaders.add(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken);
                    })
                    .build();

            //여기서 redis접근 후 exchange에 담아서 보내줌
            Map<String, Object> result = (Map<String, Object>) redisTemplate.opsForValue().get(accessToken);
            Integer id = (Integer) result.get("id");
            String role = (String) result.get("role");
            System.out.println("header에 담을 정보 :" + id);

            InfoDto infoDto = new InfoDto(id, role);
            ObjectMapper mapper = new ObjectMapper();

            try {
                String memberStr = mapper.writeValueAsString(infoDto);

                exchange.getRequest().mutate()
                        .headers(httpHeaders -> httpHeaders.add("member", memberStr)).build();
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }


            return chain.filter(exchange);
        });
    }

    private boolean isJwtValid(String jwt) {
        boolean returnValue = true;

        String subject = null;
        try {

            subject = Jwts.parser().setSigningKey(env.getProperty("jwt.secret"))
                    .parseClaimsJws(jwt).getBody()
                    .getSubject();
        }catch (Exception e){
            if(!isRefreshVaild(jwt)) { //refresh 유효시간이 끝났으면
                System.out.println("isJwtValid 만료");
                returnValue = false;

            }else{
                System.out.println("isJwtValid 유효");
                returnValue = true;
            }
        }

//        if(subject == null || subject.isEmpty()){
//            returnValue = false;
//        }


        return returnValue;
    }

    private boolean isRefreshVaild(String jwt) {

        jwt = jwt.trim();
        Map<String, Object> result = (Map<String, Object>) redisTemplate.opsForValue().get(jwt);

        if(result == null){
            System.out.println("redis null값");
            throw new NullPointerException("redis에 access token과 일치하는 값 없음");
        }
        Integer id = (Integer) result.get("id");
        String email = (String) result.get("email");
        String nickname = (String) result.get("nickname");
        String role = (String) result.get("role");
        String refreshToken = (String) result.get("refresh");

        System.out.println("isRefreshVaild . redis에서 refresh토큰 : "+refreshToken);

        MemberDto memberDto = new MemberDto(id,email, nickname, role, refreshToken);

//        ObjectMapper mapper = new ObjectMapper();
//        MemberDto memberDto = mapper.convertValue(json, MemberDto.class);
//
//        //MemberDto memberDto = redisTemplate.opsForValue().get(jwt);
//
//
        String refresh = memberDto.getRefresh();

        System.out.println(refresh);

        //refresh 만료 시간 확인
        Claims claims = Jwts.parser().setSigningKey(env.getProperty("jwt.secret")).parseClaimsJws(refresh).getBody();

        Date refreshExpriration = claims.getExpiration();
        System.out.println("isRefreshVaild에서 refresh만료 시간 : "+refreshExpriration);

        //현재 시간보다 이전이면 false
        if(refreshExpriration.before(new Date())){
            System.out.println("isRefreshVaild = refresh 만료");
            return false;
        }
        System.out.println("isRefreshVaild = refresh 유효");
        //access재발급
        Claims reclaims = Jwts.claims().setSubject(memberDto.getEmail());
        reclaims.put("email", memberDto.getEmail());
        reclaims.put("nickname", memberDto.getNickname());

        accessToken = createAccessToken(reclaims);

        System.out.println("새로 발급 된 access token : " + accessToken);

        redisTemplate.delete(jwt); //기존 access token 정보 제거

        redisTemplate.opsForValue().set(accessToken, memberDto); //새로 발급된 access token을 키 값으로 추가
        redisTemplate.expireAt(accessToken, refreshExpriration); //이 키의 값이 정해진 날짜에 삭제


        return true;
    }

    private String createAccessToken(Claims reclaims) {
        Date now = new Date();
        Date expiresIn = new Date(now.getTime() + accessTokenValidityTime);

        String accessToken =  Jwts.builder()
                .setClaims(reclaims)
                .setIssuedAt(now)
                .setExpiration(expiresIn)
                .signWith(SignatureAlgorithm.HS512, secret_key)
                .compact();

        return accessToken;
    }


    private Mono<Void> onError(ServerWebExchange exchange,
                               String err,
                               HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);

        log.error(err);
        return response.setComplete();
    }

    public static class Config {
        // application.yml 파일에서 지정한 filer의 Argument값을 받는 부분
    }
}
