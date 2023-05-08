package com.ssafy.teamservice.service;

import com.ssafy.teamservice.client.MemberServiceClient;
import com.ssafy.teamservice.config.MapperConfig;
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.jpa.TeamMemberRepository;
import com.ssafy.teamservice.jpa.TeamRepository;
import com.ssafy.teamservice.utils.error.ErrorCode;
import com.ssafy.teamservice.utils.exception.CustomException;
import com.ssafy.teamservice.vo.MemberVO;
import com.ssafy.teamservice.vo.dto.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamDetailVO;
import com.ssafy.teamservice.vo.TeamVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TeamServiceImpl implements TeamService{
    private final MapperConfig mapperConfig;
    private final TeamRepository teamRepository;
    private final TeamMemberRepository teamMemberRepository;
    private final MemberServiceClient memberServiceClient;

    public TeamServiceImpl(MapperConfig mapperConfig, TeamRepository teamRepository,
                           TeamMemberRepository teamMemberRepository, MemberServiceClient memberServiceClient) {
        this.mapperConfig = mapperConfig;
        this.teamRepository = teamRepository;
        this.teamMemberRepository = teamMemberRepository;
        this.memberServiceClient = memberServiceClient;
    }

    /**
     * 그룹(팀) 생성
     * @param teamDetailVO
     * @return
     */
    @Override
    public TeamEntity createTeam(TeamDetailVO teamDetailVO) {

        TeamEntity teamEntity = TeamEntity.builder()
                .name(teamDetailVO.getName())
                .image(teamDetailVO.getImage())
                .capacity(teamDetailVO.getCapacity())
                .isDeleted(teamDetailVO.getIsDeleted())
                .teamOwnerId(teamDetailVO.getTeamOwnerId())
                .build();

        teamRepository.save(teamEntity);
        return teamEntity;
    }

    /**
     * 팀 상세정보 엔티티 조회
     * @param teamVO
     * @return
     */
    @Override
    public TeamEntity findById(TeamVO teamVO) {
        return teamRepository.findById(teamVO.getTeamId())
                .orElseThrow(() -> new CustomException(ErrorCode.DATA_NOT_FOUND));
    }

    @Override
    public TeamEntity updateCapacity(TeamVO teamVO, boolean isIn) {
        TeamEntity teamEntity = findById(teamVO);
        if(isIn) teamEntity.updateCapacity(teamEntity.getCapacity() + 1);
        else teamEntity.updateCapacity(teamEntity.getCapacity() - 1);
        return teamEntity;
    }

    @Override
    public void updateIsDeleteTrue(TeamVO teamVO) {
        TeamEntity teamEntity = findById(teamVO);
        teamEntity.updateIsDelete();
    }

    /**
     * 팀 상세정보 DTO 조회
     * @param teamVO
     * @return
     */
    @Override
    public TeamDetailsResponseDto getTeamDetails(TeamVO teamVO) {
        TeamEntity teamEntity = findById(teamVO);

        if(teamEntity.getIsDeleted() == 1) {
            throw new CustomException(ErrorCode.DATA_NOT_FOUND);
        }

        List<Long> memberList = teamMemberRepository.findByTeamEntity(teamEntity);

        // List<Long> -> List<MemberVO> 로 만들기
        List<MemberVO> memberResultList = memberList.stream()
                .map(memberId -> memberServiceClient.getOrders(memberId))
                .collect(Collectors.toList());

        // 투표 리스트 조회

        TeamDetailsResponseDto teamDetailsResponseDto = new TeamDetailsResponseDto(teamEntity, memberResultList);
        return teamDetailsResponseDto;
    }

    /**
     * 팀 아이디 존재 여부 확인
     * @param teamVO
     * @return
     */
    @Override
    public boolean existsById(TeamVO teamVO) {
        return teamRepository.existsById(teamVO.getTeamId());
    }
}
