package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.dto.FCMNotificationRequestDto;

public interface FCMService {
    String sendNotificationByToken(FCMNotificationRequestDto requestDto);
}
