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
    private String role;
    private String refresh;
}
