package com.ssafy.notificationservice.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * 응모 오픈 알림 ⇒ 타입, 라우팅 아이디(응모 아이디), 시간, 띄어줄 명, 젠더, is_read
 */
@Entity
@Getter
@Table(name = "notification")
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Builder
public class NotificationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private Long memberId;
    @Column(nullable = false)
    private Type type;
    @Column(nullable = true)
    private Long routingId;
    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime regDate;
    @Column(nullable = false)
    private String title;
    @Column(nullable = false)
    private Gender gender;
    @Builder
    public NotificationEntity(Long memberId, Type type, String title, Gender gender) {
        this.memberId = memberId;
        this.type = type;
        this.title = title;
        this.gender = gender;
    }
    @Builder
    public NotificationEntity(Long memberId, Type type, Long routingId, String title, Gender gender) {
        this.memberId = memberId;
        this.type = type;
        this.routingId = routingId;
        this.title = title;
        this.gender = gender;
    }
}
