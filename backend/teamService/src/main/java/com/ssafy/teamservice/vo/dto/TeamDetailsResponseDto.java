package com.ssafy.teamservice.vo.dto;

import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.MemberVO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 추후 투표 리스트 추가(전체) + 시스템 투표
 */
@Getter
@Setter
public class TeamDetailsResponseDto {
    private Long id;
    private String name;
    private String image;
    private int capacity;
    private List<MemberVO> memberList;

    // private List<VoteVO> voteList;

    public TeamDetailsResponseDto(TeamEntity teamEntity, List<MemberVO> memberList) {
        this.id = teamEntity.getId();
        this.name = teamEntity.getName();
        this.image = teamEntity.getImage();
        this.capacity = teamEntity.getCapacity();
        this.memberList = memberList;
    }
}
