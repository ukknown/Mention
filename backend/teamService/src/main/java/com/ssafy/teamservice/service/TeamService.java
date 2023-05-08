package com.ssafy.teamservice.service;

import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamDetailVO;
import com.ssafy.teamservice.vo.TeamVO;

public interface TeamService {

    TeamEntity createTeam(TeamDetailVO teamDetailVO);
    TeamDetailsResponseDto getTeamDetails(TeamVO teamVO);
    boolean existsById(TeamVO teamVO);
    TeamEntity findById(TeamVO teamVO);
    TeamEntity updateCapacity(TeamVO teamVO, boolean isIn);
    void updateIsDeleteTrue(TeamVO teamVO);
}
