package com.ssafy.teamservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamMemberRepository extends JpaRepository<TeamMemberEntity, Long> {
    boolean existsByMemberIdAndTeamEntity(Long memberId, TeamEntity teamEntity);
}
