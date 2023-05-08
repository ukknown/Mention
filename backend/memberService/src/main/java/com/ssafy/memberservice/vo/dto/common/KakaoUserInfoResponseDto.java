package com.ssafy.memberservice.vo.dto.common;

import com.ssafy.memberservice.vo.Gender;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KakaoUserInfoResponseDto {
    private Long id;
    private String email;
    private Gender gender;
    private String profileImage;
    private String nickname;
}
