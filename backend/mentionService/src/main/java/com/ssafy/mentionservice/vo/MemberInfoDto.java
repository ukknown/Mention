package com.ssafy.mentionservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemberInfoDto {
    private String nickname;
    private String profileImage;
    private String gender;
    private int bang;
}
