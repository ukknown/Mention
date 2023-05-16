package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.exception.MentionServiceExceptionEnum;
import com.ssafy.mentionservice.exception.MentionServiceRuntimeException;
import com.ssafy.mentionservice.feignclient.MemberServiceFeignClient;
import com.ssafy.mentionservice.feignclient.TeamServiceFeignClient;
import com.ssafy.mentionservice.jpa.*;
import com.ssafy.mentionservice.vo.CreateMentionRequestDto;
import com.ssafy.mentionservice.vo.MentionDetailResponseDto;
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
    private final MemberServiceFeignClient memberServiceFeignClient;
    private final TeamServiceFeignClient teamServiceFeignClient;
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
        vote.updateParticipant();
        int total = teamServiceFeignClient.getTeamMemberCount(vote.getTeamId());
        if (vote.getParticipant() + 1 == total) {
            vote.updateIsCompleted();
        }
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
                    String gender = memberServiceFeignClient.getMemberInfo(mention.getVoterId()).getGender();
                    TopicEntity topic = mention.getVote().getTopic();
                    return MentionResponseDto.builder()
                            .mentionId(mention.getId())
                            .topicTitle(topic.getTitle())
                            .hintStatus(mention.getHintStatus())
                            .voterGender(gender)
                            .emoji(topic.getEmoji())
                            .build();
                })
                .collect(Collectors.toList());
    }

    @Override
    public MentionDetailResponseDto getMentionDetail(Long mentionId) {
        MentionEntity mention = mentionRepository.findById(mentionId)
                .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.MENTION_NOT_EXIST));
        return createMentionDetailResponseDto(mention);
    }

    private MentionDetailResponseDto createMentionDetailResponseDto(MentionEntity mention) {
        int hintStatus = mention.getHintStatus();
        //TODO 뱅 받아와서 넣기
        int bang = 0;
        String hintOne = "yet";
        String hintTwo = "yet";
        String hintThree = "yet";
        String nickname = "";
        String profileImg = "yet";
        Long memberId = 0L;

        if (hintStatus >= 1) {
            hintOne = mention.getHint();
        }
        if (hintStatus >= 2) {
            memberId = mention.getVoterId();
            //TODO memberId를 가지고 member에 요청해서 이름 받아와서 nickname에 넣기
            //TODO 초성분리
        }
        if (hintStatus >= 3) {
            hintThree = nickname;
            //TODO memberId를 기반으로 프사를 받아와야 합니다.
        }
        return new MentionDetailResponseDto(hintStatus, hintOne, hintTwo, hintThree, profileImg, bang);
    }

}
