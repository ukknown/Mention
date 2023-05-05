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
    @Column(length = 100, nullable = false)
    private String code;
}
