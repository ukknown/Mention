package com.ssafy.mentionservice.controller;

import com.ssafy.mentionservice.service.MentionService;
import com.ssafy.mentionservice.service.VoteService;
import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import com.ssafy.mentionservice.vo.VoteResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mention-service")
public class MentionController {

    private final MentionService mentionService;
    private final VoteService voteService;
    @GetMapping("/health-check")
    public String checkConnection(){
        return "MentionService Check Completed!";
    }

    //투표 생성
    @PostMapping("/vote/create")
    public ResponseEntity<?> createVote(@RequestBody CreateVoteRequestDto createVoteRequestDto) {
        voteService.createVote(createVoteRequestDto);
        return ResponseEntity.ok().body("투표 생성 완료");
    }

    // 그룹에서 진행중인 투표 조회
    @GetMapping("/vote/{teamId}")
    public ResponseEntity<List<VoteResponseDto>> getVoteList(@PathVariable Long teamId) {
        return ResponseEntity.ok().body(voteService.getVoteList(teamId));
    }




}
