package com.ssafy.teamservice.utils.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    DATA_NOT_FOUND(NOT_FOUND, "해당 아이디와 일치하는 데이터가 존재하지 않습니다.");
    private final HttpStatus httpStatus;
    private final String message;
}
