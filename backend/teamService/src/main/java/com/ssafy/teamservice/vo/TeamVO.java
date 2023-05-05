package com.ssafy.teamservice.vo;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
public class TeamVO {
    private String name;
    private String image;
    private int capacity;
    private boolean isDeleted;
    // private String code;
}
