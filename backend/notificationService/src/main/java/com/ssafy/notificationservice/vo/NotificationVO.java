package com.ssafy.notificationservice.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ssafy.notificationservice.jpa.Gender;
import com.ssafy.notificationservice.jpa.NotificationEntity;
import com.ssafy.notificationservice.jpa.Type;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_EMPTY)
@NoArgsConstructor
public class NotificationVO {
    private Long id;
    private Long memberId;
    private Type type;
    private Long routingId;
    private LocalDateTime regDate;
    private String title;
    private Gender gender;

    public NotificationVO(NotificationEntity notification) {
        this.id = notification.getId();
        this.type = notification.getType();
        this.routingId = notification.getRoutingId();
        this.regDate = notification.getRegDate();
        this.title = notification.getTitle();
        this.gender = notification.getGender();
    }
}
