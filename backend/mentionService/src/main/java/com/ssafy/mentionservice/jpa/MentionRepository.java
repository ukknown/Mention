package com.ssafy.mentionservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MentionRepository extends JpaRepository<MentionEntity, Long> {

}
