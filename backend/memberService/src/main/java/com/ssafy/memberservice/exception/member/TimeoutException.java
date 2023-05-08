package com.ssafy.memberservice.exception.member;

import lombok.Getter;

@Getter
public class TimeoutException extends RuntimeException{
    public TimeoutException(String message) {
        super(message);
    }
}
