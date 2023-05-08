package com.ssafy.mentionservice.vo;

import lombok.Getter;

@Getter
public class CreateVoteRequestDto {
    private Long teamId;
    private String topicTitle;
}
