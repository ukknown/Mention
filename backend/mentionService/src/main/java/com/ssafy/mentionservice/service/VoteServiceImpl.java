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
import java.util.Comparator;
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
    @Transactional
    public List<VoteVo> getVoteList(Long teamId, Long memberId, String type) {
        // 만료된 투표를 업데이트
        updateExpiredVotes();
        // 시스템 토픽을 모두 가져옴
        List<TopicEntity> systemTopics = topicRepository.findAllByIsSystemIsTrue();
        // 해당 멤버가 투표한 투표 ID들을 가져옴
        List<Long> voteIdList = mentionRepository.findAllByVoterId(memberId)
                .stream()
                .map(mention -> mention.getVote().getId())
                .collect(Collectors.toList());
        // 팀에 속한 완료되지 않은 모든 투표들을 가져옴
        List<VoteEntity> voteList = voteRepository.findAllByTeamIdAndIsCompletedIsFalseOrderByDueDateAsc(teamId);
        List<VoteVo> voteVoList = new ArrayList<>();

        // 시스템 토픽 투표를 추가
        for (TopicEntity topic : systemTopics) {
            // 해당 팀과 토픽에 대한 투표가 없는 경우 새로운 투표를 생성
            if (!voteRepository.existsByTeamIdAndTopicId(teamId, topic.getId())) {
                VoteEntity systemVote = VoteEntity.builder()
                        .teamId(teamId)
                        .topic(topic)
                        .isCompleted(false)
                        .participant(0)
                        .dueDate(LocalDateTime.now().plusHours(24))
                        .build();
                VoteEntity savedSystemVote = voteRepository.save(systemVote);

                // 만약 멤버가 이미 이 투표에 투표한 경우가 아니라면 투표 VO를 생성하고 리스트에 추가
                if (!voteIdList.contains(savedSystemVote.getId())) {
                    VoteVo voteVo = VoteVo.builder()
                            .voteId(savedSystemVote.getId())
                            .topicTitle(topic.getTitle())
                            .emoji(topic.getEmoji())
                            .isCompleted(false)
                            .participant(0)
                            .dueDate(LocalDateTime.now().plusHours(24))
                            .isSystem(true)
                            .build();
                    voteVoList.add(voteVo);
                }
            }
        }

        // 팀의 투표들을 리스트에 추가
        for (VoteEntity vote : voteList) {
            // 멤버가 이미 투표에 참여한 경우가 아니라면 투표 VO를 생성하고 리스트에 추가
            if (!voteIdList.contains(vote.getId())) {
                VoteVo voteVo = VoteVo.builder()
                        .voteId(vote.getId())
                        .topicTitle(vote.getTopic().getTitle())
                        .emoji(vote.getTopic().getEmoji())
                        .isCompleted(vote.getIsCompleted())
                        .participant(vote.getParticipant())
                        .dueDate(vote.getDueDate())
                        .isSystem(vote.getTopic().getIsSystem())
                        .build();
                voteVoList.add(voteVo);
            }
        }

        voteVoList = voteVoList.stream()
                .sorted(Comparator.comparing(VoteVo::getDueDate))
                .sorted(Comparator.comparing(VoteVo::getIsSystem).reversed())
                .collect(Collectors.toList());

        // 타입에 따라 처리
        if (type.equals("TWO")) {
            // "TWO" 타입의 경우 상위 2개의 투표만 반환
            return voteVoList.stream()
                    .limit(2)
                    .collect(Collectors.toList());
        } else if (type.equals("ALL")) {
            // "ALL" 타입의 경우 모든 투표를 반환
            return voteVoList;
        } else {
            // 그 외의 타입의 경우 예외를 발생시킴
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

    @Scheduled(cron = "0 23 09 * * ?")
    @Transactional
    public void setDailyTopic() {
        List<TopicEntity> allTopics = topicRepository.findAllByIsSystemIsFalse();
        Collections.shuffle(allTopics);

        List<TopicEntity> systemTopics = topicRepository.findAllByIsSystemIsTrue();
        systemTopics.forEach(TopicEntity::changeIsSystemFalse);

        for(int i = 0; i < 10 && i < allTopics.size(); i++) {
            TopicEntity topic = allTopics.get(i);
            topic.changeIsSystemTrue();
        }
    }

}
