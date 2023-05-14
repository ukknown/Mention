package com.ssafy.mentionservice.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Builder
@AllArgsConstructor
public class TopTopicVo {
    private Long topicId;
    private String topicTitle;
    private Long mentionCount;
}
