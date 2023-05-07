package com.ssafy.mentionservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteRepository extends JpaRepository<MentionEntity, Long> {

}
