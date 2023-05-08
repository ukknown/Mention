package com.ssafy.memberservice.jwt;


import com.ssafy.memberservice.exception.auth.AuthExceptionEnum;
import com.ssafy.memberservice.exception.auth.AuthRuntimeException;
import com.ssafy.memberservice.exception.member.MemberExceptionEnum;
import com.ssafy.memberservice.exception.member.MemberRuntimeException;
import com.ssafy.memberservice.jpa.MemberEntity;
import com.ssafy.memberservice.jpa.MemberRepository;
import com.ssafy.memberservice.vo.dto.MemberDto;
import com.ssafy.memberservice.vo.dto.response.TokenResponseDto;
import io.jsonwebtoken.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtTokenProvider {

    private final MemberRepository memberRepository;

//    private final StringRedisTemplate stringRedisTemplate;
    private final RedisTemplate redisTemplate;

    @Value("${jwt.secret}")
    private String secret_key;

    @Value("${jwt.token-validity-in-milliseconds}")
    private long accessTokenValidityTime;

    @Value("${jwt.refresh-token-validity-in-milliseconds}")
    private long refreshTokenValidityTime;

    @Autowired
    private UserDetailsService userDetailsService;

    public TokenResponseDto createToken(String email) {

        MemberEntity memberEntity =  memberRepository.findByEmail(email)
                .orElseThrow(() -> new MemberRuntimeException(MemberExceptionEnum.MEMBER_NOT_EXIST_EXCEPTION));

        Claims claims = Jwts.claims().setSubject(email);
        claims.put("email", memberEntity.getEmail());
        claims.put("nickname", memberEntity.getNickname());

        Date now = new Date();
        Date expiresIn = new Date(now.getTime() + refreshTokenValidityTime);

        String accessToken = createAccessToken(claims);

        String refreshToken = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(expiresIn)
                .signWith(SignatureAlgorithm.HS512, secret_key)
                .compact();

        // Redis key 이름과 값 설정
//        String redisKey = memberEntity.getEmail();
//        String redisValue = refreshToken;
        String redisKey = accessToken;
        MemberDto redisValue = new MemberDto(memberEntity.getId(),memberEntity.getEmail(), memberEntity.getNickname(), memberEntity.getRole(),refreshToken);

        // Redis에 refreshToken 저장
        redisTemplate.opsForValue().set(redisKey, redisValue);
//        stringRedisTemplate.opsForValue().set(redisKey, redisValue);

        return new TokenResponseDto(accessToken, refreshToken);
    }



    public String createAccessToken(Claims claims) {

        Date now = new Date();
        Date expiresIn = new Date(now.getTime() + accessTokenValidityTime);

        String accessToken =  Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(expiresIn)
                .signWith(SignatureAlgorithm.HS512, secret_key)
                .compact();

        return accessToken;
    }

    public Authentication getAuthentication(String token) {
        Claims claims = Jwts.parser().setSigningKey(secret_key).parseClaimsJws(token).getBody();
        UserDetails userDetails = userDetailsService.loadUserByUsername(claims.get("email").toString());
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secret_key).parseClaimsJws(token);
            return true;
        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
            log.info("잘못된 JWT 서명입니다.");
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_JWT_SIGNATURE_EXCEPTION);
        } catch (ExpiredJwtException e) {
            log.info("만료된 JWT 토큰입니다.");
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_JWT_EXPIRED_EXCEPTION);
        } catch (UnsupportedJwtException e) {
            log.info("지원하지 않는 JWT토큰입니다.");
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_JWT_SUPPORT_EXCEPTION);
        } catch (IllegalArgumentException e) {
            log.info("JWT토큰이 잘못되었습니다.");
            throw new AuthRuntimeException(AuthExceptionEnum.AUTH_JWT_SIGNATURE_EXCEPTION);
        }

    }
}
