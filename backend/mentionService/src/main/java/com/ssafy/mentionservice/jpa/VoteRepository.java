package com.ssafy.mentionservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VoteRepository extends JpaRepository<VoteEntity, Long> {

    List<VoteEntity> findAllByTeamId(Long teamId);
    List<VoteEntity> findAllByTeamIdAndIsCompletedIsFalse(Long teamId);


}
