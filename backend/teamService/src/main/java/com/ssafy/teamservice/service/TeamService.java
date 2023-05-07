package com.ssafy.teamservice.service;

import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamVO;

public interface TeamService {
    TeamEntity createTeam(TeamVO teamVO);
    TeamDetailsResponseDto getTeamDetails(Long teamId);
    boolean existsById(Long teamId);
    TeamEntity findById(Long teamId);
    TeamEntity updateCapacity(Long teamId, boolean isIn);
    void updateIsDeleteTrue(Long teamId);
}
