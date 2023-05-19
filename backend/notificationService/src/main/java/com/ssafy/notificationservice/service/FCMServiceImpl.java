package com.ssafy.notificationservice.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.notificationservice.jpa.FCMEntityRepository;
import com.ssafy.notificationservice.jpa.FCMTokenEntity;
import com.ssafy.notificationservice.vo.dto.FCMRequestDto;
import com.ssafy.notificationservice.vo.dto.SaveTokenRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class FCMServiceImpl implements FCMService {
    private final FirebaseMessaging firebaseMessaging;
    private final FCMEntityRepository fcmEntityRepository;

    @Override
    public String sendNotification(FCMRequestDto request) {
        FCMTokenEntity tokenEntity = fcmEntityRepository.findByMemberId(request.getTargetMemberId())
                .orElse(null);

        if (tokenEntity != null) {
            String token = tokenEntity.getFcmToken();
            if (token != null) {
                 Message message = Message.builder()
                        .setToken(token)
                        .putData("title", request.getTitle())
                        .putData("body", request.getBody())
                        .putData("routing", request.getRoutingId().toString())
                        .build();
                try {
                    firebaseMessaging.send(message);
                    return "알람 전송 성공~ targetId =" + request.getTargetMemberId();
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                    return "알림 전송 실패~";
                }
            } else {
                return "해당 멤버의 기기 토큰이 없습니다";
            }
        } else {
            return "멤버 아이디로 엔티티 못 찾음 memberId = " + request.getTargetMemberId();
        }
    }

    @Override
    @Transactional
    public String saveToken(Long loginMemberId, SaveTokenRequestDto saveTokenRequestDto) {
        FCMTokenEntity fcmTokenEntity = FCMTokenEntity.builder()
                .memberId(loginMemberId)
                .fcmToken(saveTokenRequestDto.getToken())
                .build();
        fcmEntityRepository.save(fcmTokenEntity);
        return "저장 완료";
    }
}

//package com.ssafy.notificationservice.service;
//
//import com.google.firebase.messaging.FirebaseMessaging;
//import com.google.firebase.messaging.FirebaseMessagingException;
//import com.google.firebase.messaging.Message;
//import com.google.firebase.messaging.Notification;
//import com.ssafy.notificationservice.jpa.FCMRepository;
//
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//@Service
//@RequiredArgsConstructor
//public class FCMServiceImpl implements FCMService {
//    private final FirebaseMessaging firebaseMessaging;
//    private final FCMRepository fcmRepository;
//
//    public void sendNotification(String token) {
//        Notification notification = Notification.builder()
//                .setTitle("")
//                .setBody("알람의 바디이다.")
//                .build();
//
//        Message message = Message.builder()
//                .setToken(token)
//                .setNotification(notification)
//                .build();
//        try {
//            firebaseMessaging.send(message);
//        } catch (FirebaseMessagingException e) {
//            e.printStackTrace();
//        }
//    }
//}

