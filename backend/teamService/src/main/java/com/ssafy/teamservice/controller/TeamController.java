package com.ssafy.teamservice.controller;

import com.ssafy.teamservice.service.TeamServiceImpl;
import com.ssafy.teamservice.utils.RandomCodeGenerator;
import com.ssafy.teamservice.utils.S3Uploader;
import com.ssafy.teamservice.vo.TeamVO;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/team-service")
public class TeamController {
    private final TeamServiceImpl teamServiceImpl;
    private final S3Uploader s3Uploader;
    private final RandomCodeGenerator randomCodeGenerator;

    public TeamController(TeamServiceImpl teamServiceImpl, S3Uploader s3Uploader, RandomCodeGenerator randomCodeGenerator) {
        this.teamServiceImpl = teamServiceImpl;
        this.s3Uploader = s3Uploader;
        this.randomCodeGenerator = randomCodeGenerator;
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
        String url = "";
         if(file != null)  url = s3Uploader.uploadFileToS3(file, "static/team-image");

        String code = randomCodeGenerator.generate();

        teamServiceImpl.createTeam(new TeamVO(name, url, 1, code));

        return ResponseEntity.status(HttpStatus.OK).body("팀 생성 완료");
    }
}
