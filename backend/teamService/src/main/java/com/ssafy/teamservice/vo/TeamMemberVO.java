package com.ssafy.teamservice.vo;

import com.ssafy.teamservice.jpa.TeamEntity;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
public class TeamMemberVO {
    private TeamEntity teamEntity;
    private Long memberId;
}
