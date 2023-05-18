package com.ssafy.notificationservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FCMEntityRepository extends JpaRepository<FCMTokenEntity, Long> {
    Optional<FCMTokenEntity> findByMemberId(Long memberId);
}
