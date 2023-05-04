package com.ssafy.memberservice.vo.dto.common;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KakaoUserInfoResponse {
    private Long id;
    private String email;
    private String nickname;
}
