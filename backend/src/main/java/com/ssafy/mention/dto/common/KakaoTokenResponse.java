package com.ssafy.mention.dto.common;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KakaoTokenResponse {

    private String accessToken;
    private String refreshToken;
}
