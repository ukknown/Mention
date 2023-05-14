package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.MentionEntity;
import com.ssafy.mentionservice.jpa.MentionRepository;
import com.ssafy.mentionservice.vo.CreateMentionRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;


@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MentionServiceImpl implements MentionService{

    private final MentionRepository mentionRepository;
    @Override
    @Transactional
    public void createMention(CreateMentionRequestDto createMentionRequestDto, Long memberId) {
        MentionEntity mentionEntity = MentionEntity
                .builder()
                .voteId(createMentionRequestDto.getVoteId())
                .voterId(memberId)
                .pickerId(createMentionRequestDto.getPickerId())
                .hint(createMentionRequestDto.getHint())
                .regDate(LocalDateTime.now())
                .build();
        mentionRepository.save(mentionEntity);
    }

}
