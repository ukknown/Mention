package com.ssafy.topicservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemberVo {

    private Long memberId;

    private String role;
}
