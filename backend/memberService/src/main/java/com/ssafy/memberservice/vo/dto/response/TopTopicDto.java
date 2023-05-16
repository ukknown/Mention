package com.ssafy.memberservice.vo.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TopTopicDto {
    private Long topicId;
    private String topicTitle;
    private int mentionCount;

}
