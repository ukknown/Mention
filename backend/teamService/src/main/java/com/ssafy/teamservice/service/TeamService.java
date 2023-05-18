package com.ssafy.teamservice.service;

import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.dto.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamDetailVO;
import com.ssafy.teamservice.vo.TeamVO;

import java.util.List;

public interface TeamService {

    TeamEntity createTeam(TeamDetailVO teamDetailVO);
    TeamDetailsResponseDto getTeamDetails(TeamVO teamVO);
    boolean existsById(TeamVO teamVO);
    TeamEntity findById(TeamVO teamVO);
    int updateCapacity(TeamVO teamVO, boolean isIn);
    void updateIsDeleteTrue(TeamVO teamVO);
    String getTeamName(TeamVO teamVO);
    int getTeamMemberCount(TeamVO teamVO);
    TeamEntity findTeamByTeamCode(int code);
}
