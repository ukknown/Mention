package com.ssafy.notificationservice.controller;

import com.ssafy.notificationservice.service.FCMService;
import com.ssafy.notificationservice.vo.dto.FCMNotificationRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/notification-service")
@RequiredArgsConstructor
public class FCMNotificationApiController {
    private final FCMService fcmService;
    @PostMapping("")
    public String sendNotificationByToken(@RequestBody FCMNotificationRequestDto fcmNotificationRequestDto){
        return fcmService.sendNotificationByToken(fcmNotificationRequestDto);
    }
}
