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

    @PostMapping("/create/vote")
    public ResponseEntity<?> createVote(@RequestBody CreateVoteRequestDto createVoteRequestDto) {
        voteService.createVote(createVoteRequestDto);
        return ResponseEntity.ok().body("투표 생성 완료");
    }

    @GetMapping("/{teamId}/vote")
    public ResponseEntity<List<VoteResponseDto>> getVoteList(@PathVariable Long teamId) {
        return ResponseEntity.ok().body(voteService.getVoteList(teamId));
    }

}
