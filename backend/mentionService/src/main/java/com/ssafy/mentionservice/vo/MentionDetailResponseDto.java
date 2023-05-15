package com.ssafy.mentionservice.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MentionDetailResponseDto {

    private int hintStatus;
    private String hintOne;
    private String hintTwo;
    private String hintThree;
    private String profileImg;
}
