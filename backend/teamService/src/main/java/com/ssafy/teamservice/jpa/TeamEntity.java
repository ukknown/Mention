package com.ssafy.teamservice.jpa;

import javax.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "team")
public class TeamEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(length = 100, nullable = false)
    private String name;
    @Column(length = 1000, nullable = false)
    private String image;
    @Column(nullable = false)
    private int capacity;
    @Column(name = "is_deleted", nullable = false)
    private int isDeleted;
    @Column(nullable = false)
    private Long teamOwnerId;

    @Column(length = 100, nullable = false)
    private int code;

    public void updateCapacity(int capacity){
        this.capacity = capacity;
    }

    public void updateIsDelete(){
        this.isDeleted = 1;
    }

    @Builder
    public TeamEntity(String name, String image, int capacity, int isDeleted, Long teamOwnerId, int code) {
        this.name = name;
        this.image = image;
        this.capacity = capacity;
        this.isDeleted = isDeleted;
        this.teamOwnerId = teamOwnerId;
        this.code = code;
    }
}
