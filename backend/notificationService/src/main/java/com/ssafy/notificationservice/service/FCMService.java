package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.dto.FCMRequestDto;

public interface FCMService {
    String sendNotification(FCMRequestDto requestDto);
}
