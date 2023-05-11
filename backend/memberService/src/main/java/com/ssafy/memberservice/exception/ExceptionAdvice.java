package com.ssafy.memberservice.exception;


import com.ssafy.memberservice.exception.auth.AuthRuntimeException;
import com.ssafy.memberservice.exception.member.MemberRuntimeException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionAdvice {

    @ExceptionHandler({MemberRuntimeException.class})
    private ResponseEntity<ExceptionResponseEntity> memberExceptionHandler(
            final MemberRuntimeException runError) {
        return new ResponseEntity<>(
                new ExceptionResponseEntity(
                        runError.getErrorEnum().getHttpStatus().value(),
                        runError.getErrorEnum().getErrorCode(),
                        runError.getMessage()
                ),
                runError.getErrorEnum().getHttpStatus());
    }

    @ExceptionHandler({AuthRuntimeException.class})
    private ResponseEntity<ExceptionResponseEntity> authExceptionHandler(
            final AuthRuntimeException runError) {
        return new ResponseEntity<>(
                new ExceptionResponseEntity(
                        runError.getErrorEnum().getHttpStatus().value(),
                        runError.getErrorEnum().getErrorCode(),
                        runError.getMessage()
                ),
                runError.getErrorEnum().getHttpStatus());
    }


}