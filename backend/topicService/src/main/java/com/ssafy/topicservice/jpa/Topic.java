package com.ssafy.topicservice.jpa;

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
public class Topic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Enumerated(EnumType.STRING)
    private ApproveStatus approveStatus; // APPROVE, PENDING, REJECT

    public void approveTopic() {
        this.approveStatus = ApproveStatus.APPROVE;
    }

    public void rejectTopic() {
        this.approveStatus = ApproveStatus.REJECT;
    }


}