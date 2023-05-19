package com.ssafy.memberservice.vo.dto.response;

import com.ssafy.memberservice.vo.Gender;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class MemberInfoDto {
    private String nickname;
    private String profileImage;
    private Gender gender;
    private int bang;


}
