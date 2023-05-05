package com.ssafy.memberservice.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ExceptionResponseEntity {
    private int status;
    private String code;
    private String message;
}

