package com.ssafy.teamservice.service;

import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamVO;

public interface TeamService {
    void createTeam(TeamVO teamVO);
    TeamDetailsResponseDto getTeamDetails(Long teamId);
    boolean existsById(Long teamId);
}
