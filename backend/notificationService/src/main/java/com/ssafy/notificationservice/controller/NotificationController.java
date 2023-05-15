package com.ssafy.notificationservice.controller;

import com.ssafy.notificationservice.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/notification-service")
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;
}
