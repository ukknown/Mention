package com.ssafy.teamservice.service;

import com.ssafy.teamservice.vo.TeamMemberVO;

public interface TeamMemberService {
    boolean existsByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO);
    void joinTeamMember(TeamMemberVO teamMemberVO);
}
