package com.ssafy.teamservice.service;

<<<<<<< HEAD
import org.springframework.stereotype.Service;

@Service
public class TeamServiceImpl implements TeamService{

=======
import com.ssafy.teamservice.config.MapperConfig;
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.jpa.TeamRepository;
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
>>>>>>> 021b236 ([back] feat : 그룹 생성 기능 추가)
}
