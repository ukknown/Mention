package com.ssafy.teamservice.vo;

import lombok.*;

@Getter
@Setter
public class TeamVO {
    private String name;
    private String image;
    private int capacity;
    private int isDeleted;
    private Long teamOwnerId;

    public TeamVO(String name, String image, Long teamOwnerId) {
        this.name = name;
        this.image = image;
        this.teamOwnerId = teamOwnerId;
        this.capacity = 1;
        this.isDeleted = 0;
    }
}
