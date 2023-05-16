package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.jpa.VoteEntity;
import com.ssafy.mentionservice.jpa.VoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class VoteSaveService {

    private final VoteRepository voteRepository;
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void saveAndFlushVote(VoteEntity voteEntity) {
        voteRepository.saveAndFlush(voteEntity);
    }
}
