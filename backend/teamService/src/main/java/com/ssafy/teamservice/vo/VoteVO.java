package com.ssafy.teamservice.vo;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class VoteVO {
    private Long voteId;
    private String topicTitle;
    private String emoji;
    private LocalDateTime dueDate;
    private int participant;
    private boolean isSystem;
}
