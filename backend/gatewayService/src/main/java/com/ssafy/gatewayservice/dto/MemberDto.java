package com.ssafy.gatewayservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto implements Serializable {
    private long id;
    private String email;
    private String nickname;
    private Role role;
    private String refresh;
}
