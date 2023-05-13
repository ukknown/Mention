package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.exception.TopicExceptionEnum;
import com.ssafy.mentionservice.exception.TopicRuntimeException;
import com.ssafy.mentionservice.jpa.*;
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

    private final MentionRepository mentionRepository;

    private final TopicRepository topicRepository;

    private final TopicService topicService;

    private List<String> dailyTopics = topicService.getDailyTopics();
    //TODO 알람 전송
    @Override
    @Transactional
    public void createVote(CreateVoteRequestDto createVoteRequestDto) {
        TopicEntity topic = topicRepository.findById(createVoteRequestDto.getTopicId())
                .orElseThrow(()-> new TopicRuntimeException(TopicExceptionEnum.TOPIC_NOT_EXIST));
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dueDate = now.plusHours(24);
        VoteEntity voteEntity = VoteEntity.builder()
                .teamId(createVoteRequestDto.getTeamId())
                .topic(topic)
                .isCompleted(false)
                .dueDate(dueDate)
                .build();
        voteRepository.save(voteEntity);
    }

    @Override
    public List<VoteResponseDto> getVoteList(Long teamId, Long memberId) {
        updateExpiredVotes();
        List<Long> voteIdList = mentionRepository.findAllByVoterId(memberId)
                .stream()
                .map(MentionEntity::getVoteId)
                .collect(Collectors.toList());
        List<VoteEntity> voteList = voteRepository.findAllByTeamIdAndIsCompletedIsFalseOrderByDueDateAsc(teamId);
        return voteList.stream()
                .filter(vote -> !voteIdList.contains(vote.getId()))
                .map(vote -> VoteResponseDto.builder()
                        .id(vote.getId())
                        .teamId(vote.getTeamId())
                        .topic(vote.getTopic())
                        .isCompleted(vote.getIsCompleted())
                        .participant(vote.getParticipant())
                        .dueDate(vote.getDueDate())
                        .build())
                .collect(Collectors.toList());
    }

    private void updateExpiredVotes() {
        List<VoteEntity> notCompletedVotes = voteRepository.findAllByIsCompletedIsFalse();
        LocalDateTime now = LocalDateTime.now();
        notCompletedVotes.forEach(vote -> {
            if (now.isAfter(vote.getDueDate())) {
                vote.updateIsCompleted();
            }
        });
    }
}
