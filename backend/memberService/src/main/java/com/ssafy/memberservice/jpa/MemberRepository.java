package com.ssafy.memberservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface MemberRepository extends
    CrudRepository<MemberEntity, Long> {

    Optional<MemberEntity> findByEmail(String email);

    void saveAndFlush(MemberEntity member);
}
