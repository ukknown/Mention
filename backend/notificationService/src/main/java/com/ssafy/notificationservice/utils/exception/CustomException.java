package com.ssafy.notificationservice.utils.exception;

import com.ssafy.notificationservice.utils.error.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomException extends RuntimeException{
    private final ErrorCode errorCode;
}
