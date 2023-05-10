package com.ssafy.notificationservice.vo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class FCMRequestDto {
    private String targetToken;
    private String title;
    private String body;
}
