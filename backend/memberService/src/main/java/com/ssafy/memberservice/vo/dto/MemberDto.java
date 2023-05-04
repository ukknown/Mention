package com.ssafy.memberservice.vo.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto implements Serializable {
    private String email;
    private String nickname;
}
