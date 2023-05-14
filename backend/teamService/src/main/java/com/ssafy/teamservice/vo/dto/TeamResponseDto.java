package com.ssafy.teamservice.vo.dto;

import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.VoteVO;
import lombok.*;

import java.util.List;

/**
 * 추후 투표 리스트 추가(2개)
 */
@Getter
@Setter
public class TeamResponseDto {
    private Long id;
    private String name;
    private String image;
    private int capacity;
    private List<VoteVO> voteList;

    public TeamResponseDto(TeamEntity teamEntity
    , List<VoteVO> voteList
    ){
        this.id = teamEntity.getId();
        this.name = teamEntity.getName();
        this.image = teamEntity.getImage();
        this.capacity = teamEntity.getCapacity();
        this.voteList = voteList;
    }
}
