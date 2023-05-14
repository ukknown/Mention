package com.ssafy.teamservice.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class TeamVO {
    private Long teamId;
    private int memberId;

    public TeamVO(int memberId) {
        this.memberId = memberId;
    }
}
