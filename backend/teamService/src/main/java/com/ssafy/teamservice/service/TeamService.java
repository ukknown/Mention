package com.ssafy.teamservice.service;

<<<<<<< HEAD
<<<<<<< HEAD
public interface TeamService {

=======
import com.ssafy.teamservice.vo.TeamVO;
import org.springframework.web.multipart.MultipartFile;

public interface TeamService {
    void createTeam(TeamVO teamVO);
>>>>>>> 021b236 ([back] feat : 그룹 생성 기능 추가)
=======
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamVO;

public interface TeamService {
    TeamEntity createTeam(TeamVO teamVO);
    TeamDetailsResponseDto getTeamDetails(Long teamId);
    boolean existsById(Long teamId);
    TeamEntity findById(Long teamId);
    TeamEntity updateCapacity(Long teamId, boolean isIn);
    void updateIsDeleteTrue(Long teamId);
>>>>>>> 69e7b74d33df925ac4911bf64191097d15ab32dd
}
