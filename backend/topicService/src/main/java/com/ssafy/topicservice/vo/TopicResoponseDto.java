package com.ssafy.topicservice.vo;

import com.ssafy.topicservice.jpa.ApproveStatus;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TopicResoponseDto {
    private Long id;

    private String title;

    private ApproveStatus approveStatus;
}
