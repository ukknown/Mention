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
    TOPIC_NAVER_EXCEPTION(HttpStatus.BAD_REQUEST, "T0002", "네이버 api 오류"),
    TYPE_NONE_EXCEPTION(HttpStatus.NOT_FOUND, "T0003", "type은 TWO or ALL"),
    VOTE_NOT_EXIST(HttpStatus.NOT_FOUND, "T0004", "id 값에 해당하는 투표가 없습니다."),
    MENTION_NOT_EXIST(HttpStatus.NOT_FOUND, "T0005", "id 값에 해당하는 멘션이 없습니다."),
    ALL_TOPIC_DONE(HttpStatus.NOT_FOUND, "T0006", "모든 토픽에 대한 투표를 완료하여 더이상 조회할 수 없습니다."),
    MENTION_HINTSTATUS_MAX(HttpStatus.BAD_REQUEST, "T0007", "힌트는 3단계 까지만 열람 가능합니다.");
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
