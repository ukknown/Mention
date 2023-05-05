package com.ssafy.teamservice.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TeamDetailsResponseDto {
    private Long id;
    private String name;
    private String image;
    private int capacity;
    private boolean isDeleted;
}
