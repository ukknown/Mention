package com.ssafy.memberservice.exception.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

@Getter
@AllArgsConstructor
public enum AuthExceptionEnum {
    AUTH_AUTHORIZATION_EXCEPTION(HttpStatus.UNAUTHORIZED, "A0001", "접근 권한이 없습니다."), //권한 관련
    AUTH_JWT_EXPIRED_EXCEPTION(HttpStatus.UNAUTHORIZED, "A0002", "JWT 토큰이 만료됐습니다."),
    AUTH_JWT_SUPPORT_EXCEPTION(HttpStatus.UNAUTHORIZED, "A0003", "지원하지 않는 JWT 토큰 입니다."),
    AUTH_JWT_SIGNATURE_EXCEPTION(HttpStatus.UNAUTHORIZED, "A0004", "잘못된 JWT 서명입니다."),
    AUTH_REFRESH_EXCEPTION(HttpStatus.UNAUTHORIZED, "A0005", "redis의 refresh와 일치하지 않습니다"),
    AUTH_KAKAO_ACCESSTOKEN_FAILED(HttpStatus.NOT_FOUND, "A0006", "카카오 로그인 오류입니다. 고객센터에 문의하세요.");

    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String errorMessage;

    public static Map<String, Object> convertMap(AuthExceptionEnum ex) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", ex.getHttpStatus().value());
        map.put("code", ex.getErrorCode());
        map.put("message", ex.getErrorMessage());

        return map;
    }


}
