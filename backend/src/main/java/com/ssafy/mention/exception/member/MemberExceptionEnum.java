package com.ssafy.mention.exception.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum MemberExceptionEnum {

    MEMBER_NOT_EXIST_EXCEPTION(HttpStatus.BAD_REQUEST, "M0001", "존재하지않는 유저입니다."),
    MEMBER_EXIST_EMAIL_EXCEPTION(HttpStatus.BAD_REQUEST, "M0002", "이미 존재하는 이메일입니다."),
    MEMBER_EXIST_NICKNAME_EXCEPTION(HttpStatus.BAD_REQUEST, "M0003", "이미 존재하는 닉네임 입니다."),
    MEMBER_KAKAO_EMAIL_EXCEPTION(HttpStatus.BAD_REQUEST, "M0004", "이메일 동의를 해주셔야 합니다.");


    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String errorMessage;
}
