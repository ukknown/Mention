package com.ssafy.mentionservice.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionAdvice {

    @ExceptionHandler({TopicRuntimeException.class})
    private ResponseEntity<ExceptionResponseEntity> topicExceptionHandler(
            final TopicRuntimeException runError) {
        return new ResponseEntity<>(
                new ExceptionResponseEntity(
                        runError.getErrorEnum().getHttpStatus().value(),
                        runError.getErrorEnum().getErrorCode(),
                        runError.getMessage()
                ),
                runError.getErrorEnum().getHttpStatus());
    }
}

