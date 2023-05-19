package com.ssafy.memberservice.vo.dto.response;

import lombok.Getter;

@Getter
public class TokenResponseDto {
    private String type;
    private String accessToken;


    public TokenResponseDto(String accessToken) {
        this.type = "Bearer";
        this.accessToken = accessToken;
    }
}
