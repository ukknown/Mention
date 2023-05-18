package com.ssafy.teamservice.controller;

import com.ssafy.teamservice.service.TeamMemberService;
import com.ssafy.teamservice.service.TeamService;
import com.ssafy.teamservice.utils.RandomImageGenerator;
import com.ssafy.teamservice.vo.*;
import com.ssafy.teamservice.vo.dto.CreateTeamRequestDto;
import com.ssafy.teamservice.vo.dto.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.dto.TeamResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ssafy.teamservice.utils.S3Uploader;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.utils.error.ErrorCode;
import com.ssafy.teamservice.utils.exception.CustomException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.json.JSONObject;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Tag(name="그룹 관리")
@RequiredArgsConstructor
@RestController
@RequestMapping("/team-service")
@Slf4j
public class TeamController {
    private final TeamService teamService;
    private final S3Uploader s3Uploader;
    private final RandomImageGenerator randomImageGenerator;
    private final TeamMemberService teamMemberService;

    /**
     * MSA 연결 확인
     * @return
     */
    @Operation(summary = "MSA 연결 체크 함수")
    @GetMapping("/health-check")
    public String checkConnection(HttpServletRequest request){
        TeamVO teamVO = convertRequestToVO(request);
        return teamVO.getMemberId() + "Team MicroService Check Completed!";
    }

    /**
     * 그룹(팀) 생성 : code는 후순위 + team_owner_id 추가
     * @param name
     * @return
     */
    @Operation(summary = "그룹(팀) 생성", description = "인증 코드는 후순위")
    @PostMapping( "/teams")
    @Transactional
    public ResponseEntity createTeam(
            HttpServletRequest request,
            CreateTeamRequestDto createTeamRequestDto
    ){
         TeamVO teamVO = convertRequestToVO(request);

         String url = randomImageGenerator.generate();
         TeamEntity teamEntity = teamService.createTeam(new TeamDetailVO(createTeamRequestDto.getName(), url, (long) teamVO.getMemberId()));

         teamMemberService.joinTeamMember(new TeamMemberVO(teamEntity, (long) teamVO.getMemberId()));

         return ResponseEntity.status(HttpStatus.OK).body("팀 생성 완료 ~ 🔥");
    }

    /**
     * 회원이 속한 팀 목록 조회 + 투표 2개(이미 참가하지 않은 투표) + isDelete 값 판별
     * @return
     */
    @Operation(summary = "회원이 속한 그룹 목록 조회", description = "회원이 속한 그룹의 정보와 진행 중인 투표 2개를 보여줍니다.")
    @GetMapping("/teams")
    public ResponseEntity<List<TeamResponseDto>> getTeam(HttpServletRequest request){
        TeamVO teamVO = convertRequestToVO(request);
        List<TeamResponseDto> result = teamMemberService.getTeamList((long) teamVO.getMemberId());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    /**
     * 그룹 상세정보 조회 + 투표 조회 추가 + 시스템 투표 조회 추가 + 그룹에 포함된 회원 리스트 추가
     * @param teamId
     * @return
     */
    @Operation(summary = "그룹 상세 정보 조회", description = "회원이 속한 그룹의 정보와 진행 중인 투표를 보여줍니다.")
    @GetMapping("/teams/{teamid}")
    public ResponseEntity<TeamDetailsResponseDto> getTeamDetails(
            HttpServletRequest request,
            @PathVariable("teamid") Long teamId
    ){
        TeamVO teamVO = convertRequestToVO(request);
        teamVO.setTeamId(teamId);

        // 존재하지 않는 아이디일 경우 -> 404 반환
        if(!teamService.existsById(teamVO)) throw new CustomException(ErrorCode.TEAM_NOT_FOUND);

        TeamDetailsResponseDto result = teamService.getTeamDetails(teamVO);

        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    /**
     * 생성된 팀 입장
     * @param request
     * @param teamId
     * @return
     */
    @Operation(summary = "그룹 입장", description = "클라이언트에서 카카오톡으로 넘겨준 그룹에 입장합니다.")
    @PostMapping("/teams/{teamid}")
    @Transactional
    public ResponseEntity joinTeam(
            HttpServletRequest request,
            @PathVariable("teamid") Long teamId
    ){
        TeamVO teamVO = convertRequestToVO(request);
        teamVO.setTeamId(teamId);

        // teamId가 존재하는지 확인 -> 404
        if(!teamService.existsById(teamVO)) throw new CustomException(ErrorCode.TEAM_NOT_FOUND);

        TeamEntity teamEntity = teamService.findById(teamVO);
        TeamMemberVO teamMemberVO = new TeamMemberVO(teamEntity, (long) teamVO.getMemberId());

        // 이미 입장한 그룹인지 확인
        if(teamMemberService.existsByMemberIdAndTeamEntity(teamMemberVO)){
            throw new CustomException(ErrorCode.CONFLICT_TEAM_MEMBER);
        }

        teamMemberService.joinTeamMember(teamMemberVO);
        teamService.updateCapacity(teamVO, true);

        return ResponseEntity.status(HttpStatus.OK).body("그룹 입장 완료 ~ 🔥");
    }

    @Operation(summary = "그룹 입장", description = "클라이언트에서 카카오톡으로 넘겨준 그룹에 입장합니다.")
    @PostMapping("/teams/code/{code}")
    @Transactional
    public ResponseEntity joinTeamByCode(
        HttpServletRequest request,
        @PathVariable("code") int code
    ){
        TeamVO teamVO = convertRequestToVO(request);

        // teamId가 존재하는지 확인 -> 404
        TeamEntity teamEntity = teamService.findTeamByTeamCode(code);
        TeamMemberVO teamMemberVO = new TeamMemberVO(teamEntity, (long) teamVO.getMemberId());

        // 이미 입장한 그룹인지 확인
        if(teamMemberService.existsByMemberIdAndTeamEntity(teamMemberVO)){
            throw new CustomException(ErrorCode.CONFLICT_TEAM_MEMBER);
        }

        teamMemberService.joinTeamMember(teamMemberVO);
        teamVO.setTeamId(teamEntity.getId());
        teamService.updateCapacity(teamVO, true);

        return ResponseEntity.status(HttpStatus.OK).body("그룹 코드로 입장 완료 ~ 🔥");
    }

    /**
     * 방장 강퇴 또는 회원이 그룹 나가기 -> 그룹은 방장이 나가거나, 다른 모든 인원이 나가면 삭제된다.
     * @param request
     * @param teamId
     * @return
     */
    @Operation(summary = "그룹 나가기", description = "방장 또는 회원은 그룹을 나갑니다. 방장이 나가거나 그룹의 모든 인원이 나가면 그룹은 삭제됩니다.")
    @DeleteMapping("/teams/{teamid}/{memberid}")
    @Transactional
    public ResponseEntity deleteMemberFromTeam(
            HttpServletRequest request,
            @PathVariable("teamid") Long teamId,
            @PathVariable("memberid") Long memberId
    ){
        TeamVO teamVO = convertRequestToVO(request);
        teamVO.setTeamId(teamId);

        // teamId가 존재하는지 확인 -> 404
        if(!teamService.existsById(teamVO)) throw new CustomException(ErrorCode.TEAM_NOT_FOUND);

        // 해당 그룹에 있는 사용자가 맞는지 확인 -> 404
        TeamEntity teamEntity = teamService.findById(teamVO);

        TeamMemberVO teamMemberVO = new TeamMemberVO(teamEntity, (long) teamVO.getMemberId());

        // 회원 토큰일 경우, 방장 토큰일 경우
        if(teamVO.getMemberId() == memberId){
            teamMemberService.deleteMemberFromTeam(teamMemberVO);
        } else if(teamVO.getMemberId() == teamEntity.getTeamOwnerId()){
            if(teamVO.getMemberId() == memberId){
                // 방장이 나가는 경우 -> 그룹은 삭제
                teamMemberService.deleteMemberFromTeam(teamMemberVO);
                teamService.updateIsDeleteTrue(teamVO);
                return ResponseEntity.status(HttpStatus.OK).body("그룹 삭제 완료 ~ 🔥");
            } else {
                // 방장이 사용자를 강퇴시키는 경우 - isKickOut 컬럼 값 1로 변경
                teamMemberService.updateIsKickOut(teamMemberVO);
            }
        } else {
            throw new CustomException(ErrorCode.UNAUTHORIZED_USER);
        }

        // team.capacity 업데이트
        teamService.updateCapacity(teamVO, false);

        return ResponseEntity.status(HttpStatus.OK).body("그룹에서 나가기/강퇴 완료 ~ 🔥");
    }

    /**
     * MSA 통신 코드
     * @param memberid
     * @return
     */
    @GetMapping("/teams/count/{memberid}")
    public ResponseEntity<Integer> getTeamCount(@PathVariable("memberid") Long memberid){
        System.out.println("im here ");
        return ResponseEntity.status(HttpStatus.OK).body(teamMemberService.getTeamCount(memberid));
    }

    @GetMapping("/teams/info/{teamid}")
    public String getTeamName(@PathVariable("teamid") Long teamId){
        return teamService.getTeamName(new TeamVO(teamId, -1));
    }

    @GetMapping("/teams/count/members/{teamid}")
    public int getTeamMemberCount(@PathVariable("teamid") Long teamId){
        return teamService.getTeamMemberCount(new TeamVO(teamId, -1));
    }

    @GetMapping("/teams/members/{teamid}")
    public List<Long> getTeamMembers(@PathVariable("teamid") Long teamId){
        return teamMemberService.getTeamMembers(new TeamVO(teamId, -1));
    }

    public TeamVO convertRequestToVO(HttpServletRequest request){
        if(request.getHeader("member") == null){
            throw new CustomException(ErrorCode.INVALID_TOKEN);
        }
        JSONObject loginMember = new JSONObject(request.getHeader("member"));
        int loginMemberId = loginMember.getInt("id");
        return new TeamVO(loginMemberId);
    }
}
