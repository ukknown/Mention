package com.ssafy.mention.jwt;

import com.ssafy.mention.domain.Member;
import com.ssafy.mention.dto.response.TokenResponse;
import com.ssafy.mention.exception.auth.AuthExceptionEnum;
import com.ssafy.mention.exception.auth.AuthRuntimeException;
import com.ssafy.mention.exception.member.MemberExceptionEnum;
import com.ssafy.mention.exception.member.MemberRuntimeException;
import com.ssafy.mention.repository.MemberRepository;
import io.jsonwebtoken.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
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

    private final StringRedisTemplate stringRedisTemplate;

    @Value("${jwt.secret}")
    private String secret_key;

    @Value("${jwt.token-validity-in-milliseconds}")
    private long accessTokenValidityTime;

    @Value("${jwt.refresh-token-validity-in-milliseconds}")
    private long refreshTokenValidityTime;

    @Autowired
    private UserDetailsService userDetailsService;

    public TokenResponse createToken(String email) {

        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new MemberRuntimeException(MemberExceptionEnum.MEMBER_NOT_EXIST_EXCEPTION));

        Claims claims = Jwts.claims();
        claims.put("email", member.getEmail());
        claims.put("nickname", member.getNickname());

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
        String redisKey = member.getEmail();
        String redisValue = refreshToken;

        // Redis에 refreshToken 저장
        stringRedisTemplate.opsForValue().set(redisKey, redisValue);

        return new TokenResponse(accessToken, refreshToken);
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
