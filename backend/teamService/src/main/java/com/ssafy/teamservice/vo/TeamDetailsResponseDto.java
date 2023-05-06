package com.ssafy.teamservice.vo;

import lombok.Getter;
import lombok.Setter;

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
    private int isDeleted;
}
