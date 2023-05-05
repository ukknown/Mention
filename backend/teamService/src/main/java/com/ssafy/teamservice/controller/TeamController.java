package com.ssafy.teamservice.controller;

import com.ssafy.teamservice.service.TeamServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/team-service")
public class TeamController {
    private final TeamServiceImpl teamServiceImpl;

    public TeamController(TeamServiceImpl teamServiceImpl) {
        this.teamServiceImpl = teamServiceImpl;
    }

    /**
     * MSA 연결 확인
     * @return
     */
    @GetMapping("/health-check")
    public String checkConnection(){
        return "Team MicroService Check Completed!";
    }

    /**
     * 그룹(팀) 생성
     * @param name
     * @param file
     * @return
     */
    @PostMapping(path = "/teams", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity createTeam(
            @RequestPart(value = "name") String name,
            @RequestPart(value = "file", required = false) MultipartFile file
    ){
        teamServiceImpl.createTeam(name, file);
        return new ResponseEntity(null, HttpStatus.OK);
    }
}
