package com.ssafy.gatewayservice.filter;


import com.ssafy.gatewayservice.dto.MemberDto;
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

@Component
@Slf4j
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {

    Environment env;

    private final RedisTemplate redisTemplate;

    @Value("${jwt.token-validity-in-milliseconds}")
    private long accessTokenValidityTime;

    @Value("${jwt.secret}")
    private String secret_key;

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

            if(!isJwtValid(jwt)){
                return onError(exchange, "JWT token is not valid", HttpStatus.UNAUTHORIZED);
            }
            //여기서 redis접근 후 exchange에 담아서 보내줌
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
            returnValue = false;
        }

        if(subject == null || subject.isEmpty()){
            returnValue = false;
        }
        //토큰 만료 확인
        Claims claims = Jwts.parser().setSigningKey(env.getProperty("jwt.secret")).parseClaimsJws(jwt).getBody();

        Date expriration = claims.getExpiration();
        log.info(""+expriration);

        if(expriration.before(new Date())){ //토큰 유효 시간이 현재 시간 이전이면 false
            if(!isRefreshVaild(jwt)){ //refresh 유효시간 확인
                returnValue = false;
            }
            returnValue = false;
        }

        return returnValue;
    }

    private boolean isRefreshVaild(String jwt) {
        MemberDto memberDto = (MemberDto) redisTemplate.opsForValue().get(jwt);

        String refresh = memberDto.getRefresh();

        //refresh 만료 시간 확인
        Claims claims = Jwts.parser().setSigningKey(env.getProperty("jwt.secret")).parseClaimsJws(refresh).getBody();

        Date expriration = claims.getExpiration();

        //현재 시간보다 이전이면 false
        if(expriration.before(new Date())){
            return false;
        }

        //access재발급
        Claims reclaims = Jwts.claims().setSubject(memberDto.getEmail());
        reclaims.put("email", memberDto.getEmail());
        reclaims.put("nickname", memberDto.getNickname());

        String accessToken = createAccessToken(reclaims);

        redisTemplate.delete(jwt); //기존 access token 정보 제거

        redisTemplate.opsForValue().set(accessToken, memberDto); //새로 발급된 access token을 키 값으로 추가

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
