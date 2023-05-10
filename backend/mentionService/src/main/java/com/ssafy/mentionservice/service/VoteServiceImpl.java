package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.VoteEntity;
import com.ssafy.mentionservice.jpa.VoteRepository;
import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import com.ssafy.mentionservice.vo.VoteResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VoteServiceImpl implements VoteService{

    private final VoteRepository voteRepository;

    //TODO 알람 전송
    @Override
    @Transactional
    public void createVote(CreateVoteRequestDto createVoteRequestDto) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dueDate = now.plusHours(24);
        VoteEntity voteEntity = VoteEntity.builder()
                .teamId(createVoteRequestDto.getTeamId())
                .topicTitle(createVoteRequestDto.getTopicTitle())
                .isCompleted(true)
                .dueDate(dueDate)
                .build();
        voteRepository.save(voteEntity);
    }

    @Override
    public List<VoteResponseDto> getVoteList(Long teamId) {
        List<VoteEntity> voteList = voteRepository.findAllByTeamIdAndIsCompletedIsFalse(teamId);
        return voteList.stream()
                .map(vote -> VoteResponseDto.builder()
                        .id(vote.getId())
                        .teamId(vote.getTeamId())
                        .topicTitle(vote.getTopicTitle())
                        .isCompleted(vote.getIsCompleted())
                        .participant(vote.getParticipant())
                        .dueDate(vote.getDueDate())
                        .build())
                .collect(Collectors.toList());
    }
}
