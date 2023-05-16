package com.ssafy.mentionservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MentionResponseDto {
    private Long mentionId;
    private String topicTitle;
    private String emoji;
    private int hintStatus;
    private String voterGender;
}
