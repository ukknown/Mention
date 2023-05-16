package com.ssafy.notificationservice.utils.exception;

import com.ssafy.notificationservice.utils.error.ErrorCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<Object> handleCustomException(CustomException ex){
        ErrorCode errorCode = ex.getErrorCode();
        String errorMessage = errorCode.getMessage();

        Map<String, Object> response = new HashMap<>();

        response.put("error", errorCode.getHttpStatus().name());
        response.put("code", errorCode.name());
        response.put("status", errorCode.getHttpStatus().value());
        response.put("message", errorMessage);

        return new ResponseEntity<>(response, errorCode.getHttpStatus());
    }
}
