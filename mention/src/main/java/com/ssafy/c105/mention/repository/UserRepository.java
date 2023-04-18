package com.ssafy.c105.mention.repository;

import com.ssafy.c105.mention.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
   // boolean existsByUsername(String username);

    User findByEmail(String email);

    boolean existsByEmail(String email);
}
