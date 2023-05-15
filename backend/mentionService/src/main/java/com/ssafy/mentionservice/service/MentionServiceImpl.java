package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.exception.MentionServiceExceptionEnum;
import com.ssafy.mentionservice.exception.MentionServiceRuntimeException;
import com.ssafy.mentionservice.jpa.*;
import com.ssafy.mentionservice.vo.CreateMentionRequestDto;
import com.ssafy.mentionservice.vo.MentionResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MentionServiceImpl implements MentionService{

    private final MentionRepository mentionRepository;
    private final VoteRepository voteRepository;
    @Override
    @Transactional
    public void createMention(CreateMentionRequestDto createMentionRequestDto, Long memberId) {
        VoteEntity vote = voteRepository.findById(createMentionRequestDto.getVoteId())
                .orElseThrow(() -> new MentionServiceRuntimeException(MentionServiceExceptionEnum.VOTE_NOT_EXIST));
        MentionEntity mentionEntity = MentionEntity
                .builder()
                .vote(vote)
                .voterId(memberId)
                .pickerId(createMentionRequestDto.getPickerId())
                .hint(createMentionRequestDto.getHint())
                .regDate(LocalDateTime.now())
                .build();
        mentionRepository.save(mentionEntity);
    }

    @Override
    public Integer getMentionCount(Long memberid) {
        Integer mentionCount = mentionRepository.countByPickerId(memberid);
        return mentionCount;
    }

    @Override
    public List<MentionResponseDto> getMention(Long memberId) {
        List<MentionEntity> mentionList = mentionRepository.findAllByPickerIdOrderByRegDateDesc(memberId);

        return mentionList.stream()
                .map(mention -> {
                    TopicEntity topic = mention.getVote().getTopic();
                    return MentionResponseDto.builder()
                            .mentionId(mention.getId())
                            .topicTitle(topic.getTitle())
                            .hintStatus(mention.getHintStatus())
                            .emoji(topic.getEmoji())
                            .build();
                })
                .collect(Collectors.toList());
    }

}
