package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import com.ssafy.mentionservice.vo.VoteResponseDto;

import java.util.List;

public interface VoteService {

    void createVote(CreateVoteRequestDto createVoteRequestDto);

    List<VoteResponseDto> getVoteList(Long teamId);
}
