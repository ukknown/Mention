package com.ssafy.mentionservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MentionDetailResponseDto {

    private int hintStatus;
    private String hintOne;
    private String hintTwo;
    private String hintThree;
    private String profileImg;
    private int bang;
}
