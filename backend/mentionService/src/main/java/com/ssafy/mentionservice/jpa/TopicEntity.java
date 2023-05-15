package com.ssafy.mentionservice.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
@Table(name = "topic")
public class TopicEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "bigint default 0", nullable = false)
    @Builder.Default
    private Long popularity = 0L;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ApproveStatus approveStatus; // APPROVE, PENDING, REJECT

    @Column(nullable = false)
    private String emoji;

    public void approveTopic() {
        this.approveStatus = ApproveStatus.APPROVE;
    }

    public void rejectTopic() {
        this.approveStatus = ApproveStatus.REJECT;
    }

    public void addPopularity() {
        this.popularity += 1;
    }
}