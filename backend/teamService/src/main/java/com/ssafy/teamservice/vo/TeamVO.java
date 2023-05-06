package com.ssafy.teamservice.vo;

import lombok.*;

@Getter
@Setter
public class TeamVO {
    private String name;
    private String image;
    private int capacity;
    private int isDeleted;
    // private String code;

    public TeamVO(String name, String image) {
        this.name = name;
        this.image = image;
        this.capacity = 1;
        this.isDeleted = 0;
    }
}
