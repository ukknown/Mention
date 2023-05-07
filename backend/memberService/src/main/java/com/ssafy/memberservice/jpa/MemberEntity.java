package com.ssafy.memberservice.jpa;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.ssafy.memberservice.vo.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String email;

    private String nickname;

    //    private String gender;
    private int timeout;
    @Enumerated(EnumType.STRING)
    private Role role;

}
