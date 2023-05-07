package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.VoteEntity;
import com.ssafy.mentionservice.jpa.VoteRepository;
import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VoteServiceImpl implements VoteService{

    private final VoteRepository voteRepository;

    @Override
    @Transactional
    public void createVote(CreateVoteRequestDto createVoteRequestDto) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dueDate = now.plusHours(24);
        VoteEntity voteEntity = VoteEntity.builder()
                .teamId(createVoteRequestDto.getTeamId())
                .topicTitle(createVoteRequestDto.getTopicTitle())
                .isCompleted(false)
                .dueDate(dueDate)
                .build();
        voteRepository.save(voteEntity);
    }

}
