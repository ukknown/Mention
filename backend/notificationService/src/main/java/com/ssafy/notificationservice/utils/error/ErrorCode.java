package com.ssafy.notificationservice.utils.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.UNAUTHORIZED;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    INVALID_TOKEN(UNAUTHORIZED, "일치하는 토큰이 존재하지 않습니다.");
    private final HttpStatus httpStatus;
    private final String message;
}
