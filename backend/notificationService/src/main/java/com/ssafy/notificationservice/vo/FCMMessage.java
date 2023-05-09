package com.ssafy.notificationservice.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Getter
public class FCMMessage {
    private Message message;
    private boolean validateOnly;

    @Builder
    public FCMMessage(Message message, boolean validateOnly) {
        this.message = message;
        this.validateOnly = validateOnly;
    }

    @Getter
    public static class Message {
        private String token;
        private Notification notification;

        @Builder
        public Message(String token, Notification notification) {
            this.token = token;
            this.notification = notification;
        }
    }

    @Getter
    public static class Notification {
        private String title;
        private String body;
        private String image;

        @Builder
        public Notification(String title, String body, String image) {
            this.title = title;
            this.body = body;
            this.image = image;
        }
    }
}

