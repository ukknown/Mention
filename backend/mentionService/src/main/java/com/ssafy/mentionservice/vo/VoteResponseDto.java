package com.ssafy.mentionservice.vo;

import com.ssafy.mentionservice.jpa.TopicEntity;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class VoteResponseDto {

    private Long id;

    private Long teamId;

    private TopicEntity topic;

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

}
