package com.ssafy.memberservice.jwt;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.memberservice.exception.auth.AuthRuntimeException;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

public class JwtTokenFilter extends OncePerRequestFilter {
    private JwtTokenProvider jwtTokenProvider;

    public JwtTokenFilter(JwtTokenProvider jwtTokenProvider) {
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {
        String token = jwtTokenProvider.resolveToken(request); //HTTP 요청 헤더에서 JWT 토큰을 읽음
        try {
            if (token != null && jwtTokenProvider.validateToken(token)) { //토큰 존재/ 유효성 검사
                Authentication auth = jwtTokenProvider.getAuthentication(token); //인증 객체 생성
                SecurityContextHolder.getContext().setAuthentication(auth); //인증 객체 저장
            }
            filterChain.doFilter(request, response);//다음 필터 컨트롤러에게 전달
        } catch (AuthRuntimeException e) { //예외처리
            SecurityContextHolder.clearContext(); //현재 스레드의 보안 컨텍스트 제거
            //상태코드와 내용유형 설정
            response.setStatus(e.getErrorEnum().getHttpStatus().value());
            response.setContentType(MediaType.APPLICATION_JSON_VALUE);
            try (OutputStream os = response.getOutputStream()) {
                ObjectMapper objectMapper = new ObjectMapper(); //ObjectMapper를 사용 json형식의 응답 본문 작성

                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("status", e.getErrorEnum().getHttpStatus().value());
                errorResponse.put("message", e.getMessage());

                objectMapper.writeValue(os, errorResponse);
                os.flush();
            }
        } catch (Exception e) {
            filterChain.doFilter(request, response);
        }
    }
}