package com.ssafy.teamservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamMemberRepository extends JpaRepository<TeamMemberEntity, Long> {
    boolean existsByMemberIdAndTeamEntity(Long memberId, TeamEntity teamEntity);
    TeamMemberEntity findByMemberIdAndTeamEntity(Long memberId, TeamEntity teamEntity);
    List<TeamMemberEntity> findTeamMemberEntityByMemberId(Long memberId);
    void deleteById(Long teamMemberId);
    List<Long> findByTeamEntity(TeamEntity teamEntity);
}
