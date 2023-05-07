package com.ssafy.teamservice.service;

import com.ssafy.teamservice.jpa.TeamMemberEntity;
import com.ssafy.teamservice.vo.TeamMemberVO;
import com.ssafy.teamservice.vo.TeamResponseDto;

import java.util.List;

public interface TeamMemberService {
    boolean existsByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO);
    TeamMemberEntity findByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO);
    void joinTeamMember(TeamMemberVO teamMemberVO);
    void deleteMemberFromTeam(TeamMemberVO teamMemberVO);
    List<TeamResponseDto> getTeamList(Long memberId);
}
