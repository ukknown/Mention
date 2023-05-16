package com.ssafy.teamservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Optional;

@Repository
public interface TeamRepository extends JpaRepository<TeamEntity, Long> {
    boolean existsById(Long teamId);
    Optional<TeamEntity> findById(Long teamId);
    @Query("SELECT tm.name FROM TeamEntity tm WHERE tm.id = :teamId")
    String getTeamNameById(@Param("teamId") Long teamId);
    @Query("SELECT capacity FROM TeamEntity WHERE id = :teamId")
    int getTeamMemberById(@Param("teamId") Long teamId);
}
