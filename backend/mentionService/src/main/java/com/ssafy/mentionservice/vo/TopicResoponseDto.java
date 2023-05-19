package com.ssafy.mentionservice.vo;

import com.ssafy.mentionservice.jpa.ApproveStatus;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TopicResoponseDto {
    private Long id;

    private String title;

    private String emoji;
}
