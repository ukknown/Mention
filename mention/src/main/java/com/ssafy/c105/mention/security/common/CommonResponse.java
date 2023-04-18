package com.ssafy.c105.mention.security.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum CommonResponse {

    SUCCESS(200,"Success"), FAIL(-1, "Fail");

    int code;
    String msg;
}
