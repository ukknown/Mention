package com.ssafy.teamservice.service;

import com.ssafy.teamservice.config.MapperConfig;
import com.ssafy.teamservice.jpa.TeamMemberEntity;
import com.ssafy.teamservice.jpa.TeamMemberRepository;
import com.ssafy.teamservice.vo.TeamMemberVO;
import com.ssafy.teamservice.vo.TeamResponseDto;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TeamMemberServiceImpl implements TeamMemberService{
    private final MapperConfig mapperConfig;
    private final TeamMemberRepository teamMemberRepository;

    public TeamMemberServiceImpl(MapperConfig mapperConfig, TeamMemberRepository teamMemberRepository) {
        this.mapperConfig = mapperConfig;
        this.teamMemberRepository = teamMemberRepository;
    }

    /**
     * team_member(그룹)에 이미 가입한 적이 있는지 확인
     * @param teamMemberVO
     * @return
     */
    @Override
    public boolean existsByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO) {
        return teamMemberRepository.existsByMemberIdAndTeamEntity(teamMemberVO.getMemberId(), teamMemberVO.getTeamEntity());
    }

    /**
     * 그룹 참여(저장)
     * @param teamMemberVO
     */
    @Override
    @Transactional
    public void joinTeamMember(TeamMemberVO teamMemberVO) {
        ModelMapper mapper = mapperConfig.modelMapper();
        TeamMemberEntity teamMemberEntity = mapper.map(teamMemberVO, TeamMemberEntity.class);
        teamMemberRepository.save(teamMemberEntity);
    }

    /**
     * 회원이 속한 그룹 정보(기본 정보 + 투표 정보) 조회
     * @param memberId
     * @return
     */
    @Override
    public List<TeamResponseDto> getTeamList(Long memberId) {
        List<TeamMemberEntity> teamMemberEntityList = teamMemberRepository.findTeamMemberEntityByMemberId(memberId);
        List<TeamResponseDto> result = new ArrayList<>();

        return teamMemberEntityList.stream()
                .map(teamEntity -> new TeamResponseDto(teamEntity.getTeamEntity())
                // , 투표 리스트 추가
                )
                .collect(Collectors.toList());
    }

}
