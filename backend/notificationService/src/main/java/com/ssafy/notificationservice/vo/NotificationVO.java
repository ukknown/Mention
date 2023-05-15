package com.ssafy.notificationservice.vo;

import com.ssafy.notificationservice.jpa.Gender;
import com.ssafy.notificationservice.jpa.Type;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
public class NotificationVO {
    private Long id;
    private Long memberId;
    private Type type;
    private Long routingId;
    private LocalDateTime regDate;
    private String title;
    private Gender gender;
}
