package com.ssafy.memberservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemberVO {
    private Long memberId;
    private String nickname;
    private String profileImage;
}


