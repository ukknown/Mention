package com.ssafy.mentionservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MentionRepository extends JpaRepository<MentionEntity, Long> {

    List<MentionEntity> findAllByVoterId(Long voterId);
    List<MentionEntity> findAllByPickerIdOrderByVoteIdAsc(Long pickerId);
    List<MentionEntity> findAllByPickerIdOrderByRegDateDesc(Long pickerId);
    Integer countByPickerId(Long pickerId);

}
