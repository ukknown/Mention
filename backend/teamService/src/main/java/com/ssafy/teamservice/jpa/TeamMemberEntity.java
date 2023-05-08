package com.ssafy.teamservice.jpa;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "team_member")
public class TeamMemberEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id")
    private TeamEntity teamEntity;

    @Column(nullable = false)
    private Long memberId;

    @Builder
    public TeamMemberEntity(TeamEntity teamEntity, Long memberId){
        this.teamEntity = teamEntity;
        this.memberId = memberId;
    }
}
