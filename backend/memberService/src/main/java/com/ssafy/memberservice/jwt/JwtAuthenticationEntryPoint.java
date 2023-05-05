package com.ssafy.memberservice.jwt;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.ssafy.memberservice.exception.auth.AuthExceptionEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@Slf4j
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(
            HttpServletRequest request,
            HttpServletResponse response,
            AuthenticationException e
    ) throws IOException {
        response.setStatus(AuthExceptionEnum.AUTH_AUTHORIZATION_EXCEPTION.getHttpStatus().value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        try (OutputStream os = response.getOutputStream()) {
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.writeValue(os,
                    AuthExceptionEnum.convertMap(AuthExceptionEnum.AUTH_AUTHORIZATION_EXCEPTION));
            os.flush();
        }
    }

}