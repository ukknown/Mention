package com.ssafy.memberservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface MemberRepository extends
    CrudRepository<MemberEntity, Long> {

}
