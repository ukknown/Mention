package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.dto.FCMRequestDto;
import com.ssafy.notificationservice.vo.dto.SaveTokenRequestDto;

public interface FCMService {
    String sendNotification(FCMRequestDto requestDto);

    String saveToken(Long loginMemberId, SaveTokenRequestDto saveTokenRequestDto);

}
