package com.ssafy.teamservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamMemberRepository extends JpaRepository<TeamMemberEntity, Long> {
    boolean existsByMemberIdAndTeamEntity(Long memberId, TeamEntity teamEntity);
    TeamMemberEntity findByMemberIdAndTeamEntity(Long memberId, TeamEntity teamEntity);
    List<TeamMemberEntity> findTeamMemberEntityByMemberId(Long memberId);
    void deleteById(Long teamMemberId);
    @Query("SELECT tm.memberId FROM TeamMemberEntity tm WHERE tm.isKickOut = 0 and tm.teamEntity = :teamEntity")
    List<Long> getMemberByTeamEntity(@Param("teamEntity") TeamEntity teamEntity);
    @Query("SELECT COUNT(tm.id) FROM TeamMemberEntity tm WHERE tm.memberId = :memberId and tm.isKickOut = 0 and tm.teamEntity.isDeleted = 0")
    int getTeamCount(@Param("memberId") Long memberId);
}
