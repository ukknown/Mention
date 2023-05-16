package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.vo.CreateMentionRequestDto;
import com.ssafy.mentionservice.vo.MentionDetailResponseDto;
import com.ssafy.mentionservice.vo.MentionResponseDto;

import java.util.List;

public interface MentionService {

    void createMention(CreateMentionRequestDto createMentionRequestDto, Long memberId);
    Integer getMentionCount(Long memberid);
    List<MentionResponseDto> getMention(Long memberId);
    MentionDetailResponseDto getMentionDetail(Long mentionId, Long memberId);
    String plusHintstatus(Long mentionId);
    String getTopicByMention(Long mentionId);

    String getTopicByVote(Long voteId);
}
