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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vote_id")
    private VoteEntity vote;

    @Column(nullable = false)
    private Long voterId;

    @Column(nullable = false)
    private Long pickerId;

    @Column(nullable = false)
    private String hint;

    @Column(nullable = false)
    private LocalDateTime regDate;

    @Column(nullable = false)
    private int hintStatus;
}
