package com.ssafy.memberservice.vo;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class MyPageVO {
    //프사, 이름, 뱅 수, 그룹 수, 받은 멘션 수, 멘션 많은 받은 토픽
    private String profileImage;
    private String nickname;
    private int bangAmount;
    private int GroupCount;
    private int mentionCount;
    private String topTopic;
}
