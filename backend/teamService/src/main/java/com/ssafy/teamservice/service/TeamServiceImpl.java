package com.ssafy.teamservice.service;

import com.ssafy.teamservice.config.MapperConfig;
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.jpa.TeamRepository;
import com.ssafy.teamservice.utils.error.ErrorCode;
import com.ssafy.teamservice.utils.exception.CustomException;
import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamVO;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
public class TeamServiceImpl implements TeamService{
    private final MapperConfig mapperConfig;
    private final TeamRepository teamRepository;

    public TeamServiceImpl(MapperConfig mapperConfig, TeamRepository teamRepository) {
        this.mapperConfig = mapperConfig;
        this.teamRepository = teamRepository;
    }

    /**
     * 그룹(팀) 생성
     *
     * @param teamVO
     * @return
     */
    @Override
    public TeamEntity createTeam(TeamVO teamVO) {
        ModelMapper mapper = mapperConfig.modelMapper();
        TeamEntity teamEntity = mapper.map(teamVO, TeamEntity.class);
        teamRepository.save(teamEntity);
        return teamEntity;
    }

    /**
     * 팀 상세정보 엔티티 조회
     * @param teamId
     * @return
     */
    @Override
    public TeamEntity findById(Long teamId) {
        return teamRepository.findById(teamId)
                .orElseThrow(() -> new CustomException(ErrorCode.DATA_NOT_FOUND));
    }

    @Override
    public TeamEntity updateCapacity(Long teamId, boolean isIn) {
        TeamEntity teamEntity = findById(teamId);
        if(isIn) teamEntity.updateCapacity(teamEntity.getCapacity() + 1);
        else teamEntity.updateCapacity(teamEntity.getCapacity() - 1);
        return teamEntity;
    }

    @Override
    public void updateIsDeleteTrue(Long teamId) {
        TeamEntity teamEntity = findById(teamId);
        teamEntity.updateIsDelete();
    }

    /**
     * 팀 상세정보 DTO 조회
     * @param teamId
     * @return
     */
    @Override
    public TeamDetailsResponseDto getTeamDetails(Long teamId) {
        ModelMapper mapper = mapperConfig.modelMapper();
        TeamDetailsResponseDto teamDetailsResponseDto = mapper.map(findById(teamId), TeamDetailsResponseDto.class);
        return teamDetailsResponseDto;
    }

    /**
     * 팀 아이디 존재 여부 확인
     * @param teamId
     * @return
     */
    @Override
    public boolean existsById(Long teamId) {
        return teamRepository.existsById(teamId);
    }
}
