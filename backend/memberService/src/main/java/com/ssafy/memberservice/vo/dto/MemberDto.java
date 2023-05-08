package com.ssafy.memberservice.vo.dto;

import com.ssafy.memberservice.vo.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto implements Serializable {
    private Long id;
    private String email;
    private String nickname;
    private Role role;
    private String refresh;
}
