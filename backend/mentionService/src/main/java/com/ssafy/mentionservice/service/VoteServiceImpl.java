package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.exception.MentionServiceExceptionEnum;
import com.ssafy.mentionservice.exception.MentionServiceRuntimeException;
import com.ssafy.mentionservice.jpa.*;
import com.ssafy.mentionservice.vo.CreateVoteRequestDto;
import com.ssafy.mentionservice.vo.VoteVo;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VoteServiceImpl implements VoteService{

    private final VoteRepository voteRepository;

    private final MentionRepository mentionRepository;

    private final TopicRepository topicRepository;


    //TODO 알람 전송
    @Override
    @Transactional
    public void createVote(CreateVoteRequestDto createVoteRequestDto) {
        TopicEntity topic = topicRepository.findById(createVoteRequestDto.getTopicId())
                .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.TOPIC_NOT_EXIST));
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
    public List<VoteVo> getVoteList(Long teamId, Long memberId, String type) {
        updateExpiredVotes();
        List<Long> voteIdList = mentionRepository.findAllByVoterId(memberId)
                .stream()
                .map(MentionEntity::getVoteId)
                .collect(Collectors.toList());
        List<VoteEntity> voteList = voteRepository.findAllByTeamIdAndIsCompletedIsFalseOrderByDueDateAsc(teamId);

        if (type.equals("TWO")) {
            return voteList.stream()
                    .filter(vote -> !voteIdList.contains(vote.getId()))
                    .map(this::mapToDto)
                    .limit(2)
                    .collect(Collectors.toList());
        } else if (type.equals("ALL")) {
            return voteList.stream()
                    .filter(vote -> !voteIdList.contains(vote.getId()))
                    .map(this::mapToDto)
                    .collect(Collectors.toList());
        } else {
            throw new MentionServiceRuntimeException(MentionServiceExceptionEnum.TYPE_NONE_EXCEPTION);
        }
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

    private List<TopicEntity> dailyTopics = new ArrayList<>();
    @Scheduled(cron = "0 51 18 * * ?")
    private void setDailyTopic() {
        List<TopicEntity> allTopics = topicRepository.findAll();
        Collections.shuffle(allTopics);
        dailyTopics.clear();
        for(int i = 0; i < 5; i++) {
            dailyTopics.add(allTopics.get(i));
        }
    }

    private VoteVo mapToDto(VoteEntity vote) {
        return VoteVo.builder()
                .voteId(vote.getId())
                .topicTitle(vote.getTopic().getTitle())
                .emoji(vote.getTopic().getEmoji())
                .isCompleted(vote.getIsCompleted())
                .participant(vote.getParticipant())
                .dueDate(vote.getDueDate())
                .build();
    }
}
