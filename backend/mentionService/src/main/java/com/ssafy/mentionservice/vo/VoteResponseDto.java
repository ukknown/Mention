package com.ssafy.mentionservice.vo;

import com.ssafy.mentionservice.jpa.TopicEntity;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class VoteResponseDto {

    private Long voteId;

    private String topicTitle;

    private String emoji;

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

}
