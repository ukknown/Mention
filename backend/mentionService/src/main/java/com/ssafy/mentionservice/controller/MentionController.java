package com.ssafy.mentionservice.controller;

import com.ssafy.mentionservice.service.MentionService;
import com.ssafy.mentionservice.service.VoteService;
import com.ssafy.mentionservice.vo.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mention-service")
@Tag(name = "멘션/투표 관리")
public class MentionController {

    private final MentionService mentionService;
    private final VoteService voteService;


    @Operation(summary = "MSA 연결 체크")
    @GetMapping("/health-check")
    public String checkConnection(HttpServletRequest request) {
        return "MentionService Check Completed!";
    }

    @Operation(summary = "투표 생성", description = "사용자가 투표를 생성합니다.")
    @PostMapping("/vote/create")
    public ResponseEntity<?> createVote(@RequestBody CreateVoteRequestDto createVoteRequestDto) {
        voteService.createVote(createVoteRequestDto);
        return ResponseEntity.ok().body("투표 생성 완료");
    }

    @Operation(summary = "그룹에서 진행중인 투표 조회", description = "TODO 토큰 받아서 본인이 진행한 것 빼고 보여줘야함.")
    @GetMapping("/teams/{teamId}/votes/{memberId}/{type}")
    public List<VoteVo> getVoteList(@PathVariable Long teamId,
                                    @PathVariable Long memberId,
                                    @PathVariable String type) {
        return voteService.getVoteList(teamId, memberId, type);
    }

    @GetMapping("/mention")
    public ResponseEntity<List<MentionResponseDto>> getMention(HttpServletRequest request) {
        Long memberId = loadMember(request).getMemberId();
        return ResponseEntity.ok().body(mentionService.getMention(memberId));
    }

    @Operation(summary = "멘션 생성", description = "상대방을 멘션!하다~")
    @PostMapping("/mention/create")
    public ResponseEntity<?> createMention(HttpServletRequest request,
                                           @RequestBody CreateMentionRequestDto createMentionRequestDto) {
        Long memberId = loadMember(request).getMemberId();
        mentionService.createMention(createMentionRequestDto, memberId);
        return ResponseEntity.ok().body("멘션 생성 완료");
    }

    private MemberVo loadMember(HttpServletRequest request) {
        JSONObject loginMember = new JSONObject(request.getHeader("member"));
        Long id = loginMember.getLong("id");
        String role = loginMember.getString("role");
        return MemberVo.builder()
                .memberId(id)
                .role(role)
                .build();
    }


}
