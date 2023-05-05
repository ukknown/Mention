package com.ssafy.teamservice.controller;

import com.ssafy.teamservice.service.TeamServiceImpl;
import com.ssafy.teamservice.utils.RandomCodeGenerator;
import com.ssafy.teamservice.utils.S3Uploader;
import com.ssafy.teamservice.utils.error.ErrorCode;
import com.ssafy.teamservice.utils.exception.CustomException;
import com.ssafy.teamservice.vo.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Tag(name="그룹 관리")
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
    @Operation(summary = "MSA 연결 체크 함수")
    @GetMapping("/health-check")
    public String checkConnection(){
        return "Team MicroService Check Completed!";
    }

    /**
     * 그룹(팀) 생성 : code는 후순위 + team_owner_id 추가
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

        // String code = randomCodeGenerator.generate();

        teamServiceImpl.createTeam(new TeamVO(name, url, 1, false));

        return ResponseEntity.status(HttpStatus.OK).body("팀 생성 완료");
    }

    /**
     * 그룹 상세정보 조회
     * @param teamId
     * @return
     */
    @GetMapping("/teams/{teamid}")
    public ResponseEntity<TeamDetailsResponseDto> getTeamDetails(
            @PathVariable("teamid") Long teamId
    ){
        // 존재하지 않는 아이디일 경우 -> 404 반환
        if(!teamServiceImpl.existsById(teamId)) throw new CustomException(ErrorCode.DATA_NOT_FOUND);

        TeamDetailsResponseDto result = teamServiceImpl.getTeamDetails(teamId);

        // 해당 방이 삭제된 경우 -> 404 반환
        if(result.isDeleted()) throw new CustomException(ErrorCode.DATA_NOT_FOUND);

        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
