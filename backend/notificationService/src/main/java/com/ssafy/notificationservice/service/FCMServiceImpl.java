package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.dto.FCMNotificationRequestDto;
import org.springframework.stereotype.Service;

@Service
public class FCMServiceImpl implements FCMService{

    @Override
    public String sendNotificationByToken(FCMNotificationRequestDto requestDto) {
        return null;
    }
}
