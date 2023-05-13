package com.ssafy.mentionservice.exception;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

@Getter
@AllArgsConstructor
public enum MentionServiceExceptionEnum {
    TOPIC_NOT_EXIST(HttpStatus.NOT_FOUND, "T0001", "id 값에 해당하는 토픽이 없습니다."),
    TOPIC_NAVER_EXCEPTION(HttpStatus.BAD_REQUEST, "T0002", "네이버 api 오류");

    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String errorMessage;

    public static Map<String, Object> convertMap(MentionServiceExceptionEnum ex) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", ex.getHttpStatus().value());
        map.put("code", ex.getErrorCode());
        map.put("message", ex.getErrorMessage());

        return map;
    }


}
