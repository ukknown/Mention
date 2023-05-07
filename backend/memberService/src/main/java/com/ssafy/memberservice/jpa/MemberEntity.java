package com.ssafy.memberservice.jpa;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.ssafy.memberservice.vo.Role;
import lombok.*;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String email;
    private String gender;
    private String nickname;
    private String profileImage;
    private  String bangAmount;
    private int timeout;
    @Enumerated(EnumType.STRING)
    private Role role;


}
