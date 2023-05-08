package com.ssafy.memberservice.jpa;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.ssafy.memberservice.vo.Gender;
import com.ssafy.memberservice.vo.Role;
import lombok.*;

@Entity
@Getter
@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "member")
public class MemberEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String email;
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Gender gender;
    @Column(nullable = false)
    private String nickname;
    @Column(nullable = false)
    private String profileImage;
    @Column(nullable = false)
    private int bangAmount;
    @Column(nullable = false)
    private int timeout;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

}
