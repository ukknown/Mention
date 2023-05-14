package com.ssafy.mentionservice.exception;

import lombok.Getter;

@Getter
public class MentionServiceRuntimeException extends RuntimeException{

    private MentionServiceExceptionEnum errorEnum;

    public MentionServiceRuntimeException(MentionServiceExceptionEnum errorEnum) {
        super(errorEnum.getErrorMessage());
        this.errorEnum = errorEnum;
    }
}
