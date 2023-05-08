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
    @NotNull
    private String email;
    @NotNull
    @Enumerated(EnumType.STRING)
    private Gender gender;
    @NotNull
    private String nickname;
    @NotNull
    private String profileImage;
    private int bangAmount;
    private int timeout;
    @Enumerated(EnumType.STRING)
    private Role role;

}
