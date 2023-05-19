package com.ssafy.mentionservice.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateVoteRequestDto {
    private Long teamId;
    private Long topicId;
}
