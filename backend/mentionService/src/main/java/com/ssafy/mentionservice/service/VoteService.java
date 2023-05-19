package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import com.ssafy.mentionservice.vo.VoteVo;

import java.util.List;

public interface VoteService {

    void createVote(CreateVoteRequestDto createVoteRequestDto);

    List<VoteVo> getVoteList(Long teamId, Long memberId, String type);
}
