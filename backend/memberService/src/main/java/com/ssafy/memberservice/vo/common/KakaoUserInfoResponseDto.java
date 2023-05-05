package com.ssafy.memberservice.vo.common;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KakaoUserInfoResponseDto {
    private Long id;
    private String email;
    private String nickname;
}
