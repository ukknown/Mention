package com.ssafy.teamservice.utils.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    UNATHORIZED(UNAUTHORIZED, "해당 기능을 실행할 권한이 없습니다."),
    INVALID_TOKEN(UNAUTHORIZED, "일치하는 토큰이 존재하지 않습니다."),
    TEAM_NOT_FOUND(NOT_FOUND, "해당 팀 아이디와 일치하는 데이터가 존재하지 않습니다."),
    MEMBER_NOT_FOUND(NOT_FOUND, "해당 팀 안에 회원이 존재하지 않습니다."),
    FILE_UPLOAD_ERROR(SERVICE_UNAVAILABLE, "S3 업로드 : 파일 변환 실패"),
    CONFLICT_TEAM_MEMBER(CONFLICT, "이미 그룹에 가입한 멤버입니다.");

    private final HttpStatus httpStatus;
    private final String message;
}
