package com.ssafy.teamservice.jpa;

import javax.persistence.*;
import lombok.*;

/**
 * team_owner_id 추가
 */
@Entity
@Getter
@ToString
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
//    @Column(length = 100, nullable = false)
//    private String code;

    public void updateCapacity(int capacity){
        this.capacity = capacity;
    }

    public void updateIsDelete(){
        this.isDeleted = 1;
    }
}
