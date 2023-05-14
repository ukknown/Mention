package com.ssafy.notificationservice.jpa;

import lombok.Getter;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * 응모 오픈 알림 ⇒ 타입, 라우팅 아이디(응모 아이디), 시간, 띄어줄 명, 젠더, is_read
 */
@Entity
@Getter
@Table(name = "notification")
public class NotificationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private Type type;
    @Column(nullable = false)
    private Long routingId;
    @Column(nullable = false)
    private LocalDateTime regDate;
    @Column(nullable = false)
    private String title;
    @Column(nullable = false)
    private Gender gender;
}
