package com.ssafy.mentionservice.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class VoteEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long teamId;

    private String topicTitle;

    private Boolean isCompleted;

    private int participant;

    private LocalDateTime dueDate;

    @PostLoad
    public void updateIsCompleted() {
        if (!isCompleted && LocalDateTime.now().isAfter(dueDate)) {
            isCompleted = true;
        }
    }

}
