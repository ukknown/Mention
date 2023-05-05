package com.ssafy.teamservice.jpa;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeamRepository extends CrudRepository<TeamEntity, Long> {
    boolean existsById(Long teamId);
    Optional<TeamEntity> findById(Long teamId);
}
