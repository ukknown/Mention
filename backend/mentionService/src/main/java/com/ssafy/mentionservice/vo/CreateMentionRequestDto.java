package com.ssafy.mentionservice.vo;

import lombok.Getter;

@Getter
public class CreateMentionRequestDto {
     private Long voteId;
     private Long pickerId;
     private String hint;
}
