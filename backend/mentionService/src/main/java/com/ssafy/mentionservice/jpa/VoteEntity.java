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

    private Long teamId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id")
    private TopicEntity topic;

    @OneToMany(mappedBy = "vote", cascade = CascadeType.ALL)
    private List<MentionEntity> mention = new ArrayList<>();

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

    public void updateIsCompleted() {
        this.isCompleted = true;
    }
}
