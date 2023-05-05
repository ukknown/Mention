package com.ssafy.teamservice.service;

import com.ssafy.teamservice.vo.TeamVO;
import org.springframework.web.multipart.MultipartFile;

public interface TeamService {
    void createTeam(TeamVO teamVO);
}
