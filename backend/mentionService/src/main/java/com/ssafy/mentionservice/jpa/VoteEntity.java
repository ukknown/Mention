package com.ssafy.mentionservice.jpa;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

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

    private Long teamId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id")
    private TopicEntity topic;

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

    public void updateIsCompleted() {
        this.isCompleted = true;
    }
}
