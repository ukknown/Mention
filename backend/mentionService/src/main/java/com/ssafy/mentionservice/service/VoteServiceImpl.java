package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.VoteRepository;
import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class VoteServiceImpl {

    private final VoteRepository voteRepository;

    }
