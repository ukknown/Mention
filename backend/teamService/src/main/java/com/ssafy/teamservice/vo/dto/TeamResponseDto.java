package com.ssafy.teamservice.vo.dto;

import com.ssafy.teamservice.jpa.TeamEntity;
import lombok.*;

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
//    private List<Vote> voteList;

    public TeamResponseDto(TeamEntity teamEntity
//    , List<Vote> voteList
    ){
        this.id = teamEntity.getId();
        this.name = teamEntity.getName();
        this.image = teamEntity.getImage();
        this.capacity = teamEntity.getCapacity();
//        this.voteList = voteList;
    }
}
