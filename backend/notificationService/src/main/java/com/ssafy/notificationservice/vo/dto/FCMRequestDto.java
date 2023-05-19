package com.ssafy.notificationservice.vo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FCMRequestDto {
    private Long targetMemberId;
    private String title;
    private String body;
    private Long routingId;
    @Builder
    public FCMRequestDto(Long targetMemberId, String title, String body, Long routingId) {
        this.targetMemberId = targetMemberId;
        this.title = title;
        this.body = body;
        this.routingId = routingId;
    }
}
