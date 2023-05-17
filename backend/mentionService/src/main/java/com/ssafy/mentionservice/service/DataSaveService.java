package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.MentionEntity;
import com.ssafy.mentionservice.jpa.MentionRepository;
import com.ssafy.mentionservice.jpa.VoteEntity;
import com.ssafy.mentionservice.jpa.VoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DataSaveService {

    private final VoteRepository voteRepository;
    private final MentionRepository mentionRepository;
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void saveAndFlushVote(VoteEntity voteEntity) {
        voteRepository.saveAndFlush(voteEntity);
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void saveAndFlushMention(MentionEntity mentionEntity) {
        mentionRepository.saveAndFlush(mentionEntity);
    }
}
