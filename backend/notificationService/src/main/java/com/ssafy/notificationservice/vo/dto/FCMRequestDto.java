package com.ssafy.notificationservice.vo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FCMRequestDto {
    private Long targetMemberId;
    private String title;
    private String body;
    @Builder
    public FCMRequestDto(Long targetMemberId, String title, String body) {
        this.targetMemberId = targetMemberId;
        this.title = title;
        this.body = body;
    }
}
