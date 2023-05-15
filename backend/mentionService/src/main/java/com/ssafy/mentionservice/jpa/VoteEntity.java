package com.ssafy.mentionservice.jpa;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
@Table(name = "vote")
public class VoteEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long teamId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id")
    private TopicEntity topic;

    @Column(nullable = false)
    private Boolean isCompleted;

    @Column(nullable = false)
    private int participant;

    @Column(nullable = false)
    private LocalDateTime dueDate;

    public void updateIsCompleted() {
        this.isCompleted = true;
    }

    public void updateParticipant() {
        this.participant += 1;
    }
}
