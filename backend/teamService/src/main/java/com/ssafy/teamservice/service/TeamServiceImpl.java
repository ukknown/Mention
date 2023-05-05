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
import org.springframework.transaction.annotation.Transactional;

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
     * @param teamVO
     */
    @Override
    @Transactional
    public void createTeam(TeamVO teamVO) {
        ModelMapper mapper = mapperConfig.modelMapper();
        TeamEntity teamEntity = mapper.map(teamVO, TeamEntity.class);
        teamRepository.save(teamEntity);
    }

    /**
     * 팀 상세정보 조회
     * @param teamId
     * @return
     */
    @Override
    public TeamDetailsResponseDto getTeamDetails(Long teamId) {
        return null;
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

    /**
     * 팀 상세정보 조회
     * @param teamId
     * @return
     */
    @Override
    public TeamDetailsResponseDto findById(Long teamId) {
        TeamEntity teamEntity = teamRepository.findById(teamId)
                .orElseThrow(() -> new CustomException(ErrorCode.DATA_NOT_FOUND));

        ModelMapper mapper = mapperConfig.modelMapper();
        TeamDetailsResponseDto teamDetailsResponseDto = mapper.map(teamEntity, TeamDetailsResponseDto.class);

        return teamDetailsResponseDto;
    }
}
