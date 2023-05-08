package com.ssafy.teamservice.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class TeamVO {
    private Long teamId;
    private Long memberId;

    public TeamVO(Long teamId) {
        this.teamId = teamId;
    }
}
