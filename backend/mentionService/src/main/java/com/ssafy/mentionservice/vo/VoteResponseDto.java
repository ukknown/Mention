package com.ssafy.mentionservice.vo;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class VoteResponseDto {

    private Long id;

    private Long teamId;

    private String topicTitle;

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

}
