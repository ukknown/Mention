package com.ssafy.mentionservice.jpa;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
@Table(name = "mention")
public class MentionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long voteId;

    private Long voterId;

    private Long pickerId;

    private String hint;

    private LocalDateTime regDate;

    private int hintStatus;
}
