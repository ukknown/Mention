package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.vo.CreateMentionRequestDto;

public interface MentionService {

    void createMention(CreateMentionRequestDto createMentionRequestDto, Long memberId);
}
