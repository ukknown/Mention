package com.ssafy.memberservice.jpa;

import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface MemberRepository extends
    CrudRepository<Member, Long> {

    Optional<Member> findByEmail(String email);

    void saveAndFlush(Member member);
}
