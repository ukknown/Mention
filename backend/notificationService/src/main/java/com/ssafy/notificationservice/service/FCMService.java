package com.ssafy.notificationservice.service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.ssafy.notificationservice.vo.dto.FCMNotificationRequestDto;

import java.io.*;

public interface FCMService {
    String sendNotificationByToken(FCMNotificationRequestDto requestDto);
    String getAccessToken() throws IOException;
    void sendMessageTo(String targetToken, String title, String body) throws IOException;
    String makeMessage(String targetToken, String title, String body) throws JsonParseException, JsonProcessingException;

}
