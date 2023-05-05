package com.ssafy.memberservice.vo.common;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KakaoTokenResponseDto {

    private String accessToken;
    private String refreshToken;
}
