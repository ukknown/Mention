package com.ssafy.memberservice.vo.dto.response;

import lombok.Getter;

@Getter
public class TokenResponseDto {
    private String type;
    private String accessToken;
    private String refreshToken;

    public TokenResponseDto(String accessToken, String refreshToken) {
        this.type = "Bearer";
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
