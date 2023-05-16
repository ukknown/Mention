package com.ssafy.notificationservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.gson.JsonParseException;
import com.ssafy.notificationservice.vo.FCMMessage;
import com.ssafy.notificationservice.vo.dto.FCMRequestDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.Arrays;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMServiceImpl implements FCMService{
//    private final ObjectMapper objectMapper;
//
//    @Override
//    public String sendNotificationByToken(FCMRequestDto requestDto) {
//        // test
//        return null;
//    }
//
//    @Override
//    public String getAccessToken() throws IOException {
//        GoogleCredentials googleCredentials = GoogleCredentials
//                .fromStream(new ClassPathResource("firebase/firebase-admin.json").getInputStream())
//                .createScoped(Arrays.asList("https://www.googleapis.com/auth/cloud-platform"));
//
//        googleCredentials.refreshIfExpired();
//
//        return googleCredentials.getAccessToken().getTokenValue();
//    }
//
//    @Override
//    public void sendMessageTo(String targetToken, String title, String body) throws IOException {
//        String message = makeMessage(targetToken, title, body);
//        log.info("Bearer " + targetToken);
//
//        OkHttpClient okHttpClient = new OkHttpClient();
//
//        RequestBody requestBody = RequestBody.create(message,
//                MediaType.get("application/json; charset=utf-8"));
//
//        Request request = new Request.Builder()
//                .post(requestBody)
//                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
//                .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
//                .build();
//
//        log.info("Bearer " + getAccessToken());
//        Response response = okHttpClient.newCall(request).execute();
//
//        log.info(response.body().string());
//    }
//
//
//    public String makeMessage(String targetToken, String title, String body) throws JsonParseException, JsonProcessingException {
//        FCMMessage fcmMessage = FCMMessage.builder()
//                .message(FCMMessage.Message.builder()
//                        .token(targetToken)
//                        .notification(FCMMessage.Notification.builder()
//                                .title(title)
//                                .body(body)
//                                .image(null)
//                                .build()
//                        ).build()).validateOnly(false).build();
//
//        return objectMapper.writeValueAsString(fcmMessage);
//    }
}
