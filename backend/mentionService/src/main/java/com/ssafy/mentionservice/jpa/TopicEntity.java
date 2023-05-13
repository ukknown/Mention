package com.ssafy.mentionservice.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

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

    private String title;

    @Column(columnDefinition = "bigint default 0")
    @Builder.Default
    private Long popularity = 0L;

    @Enumerated(EnumType.STRING)
    private ApproveStatus approveStatus; // APPROVE, PENDING, REJECT

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