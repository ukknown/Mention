package com.ssafy.notificationservice.controller;

import com.ssafy.notificationservice.service.FCMService;
import com.ssafy.notificationservice.vo.dto.FCMRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

//@RestController
//@RequestMapping("/notification-service")
//@RequiredArgsConstructor
public class FCMController {
//    private final FCMService fcmService;
//
//    @GetMapping("/health-check")
//    public ResponseEntity healthCheck(){
//        return ResponseEntity.ok().body("Notification Service Check Completed!");
//    }
//
//    @PostMapping("/fcm")
//    public ResponseEntity pushMessage(@RequestBody FCMRequestDto fcmRequestDto)
//    throws IOException {
//
//        fcmService.sendMessageTo(fcmRequestDto.getTargetToken(),
//                fcmRequestDto.getTitle(),
//                fcmRequestDto.getBody());
//
//        return ResponseEntity.ok().build();
//    }
}
