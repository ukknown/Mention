package com.ssafy.topicservice.exception;

import lombok.Getter;

@Getter
public class TopicRuntimeException extends RuntimeException{

    private TopicExceptionEnum errorEnum;

    public TopicRuntimeException(TopicExceptionEnum errorEnum) {
        super(errorEnum.getErrorMessage());
        this.errorEnum = errorEnum;
    }
}
