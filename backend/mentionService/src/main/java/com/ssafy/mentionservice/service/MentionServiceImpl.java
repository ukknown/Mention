package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.exception.MentionServiceExceptionEnum;
import com.ssafy.mentionservice.exception.MentionServiceRuntimeException;
import com.ssafy.mentionservice.feignclient.MemberServiceFeignClient;
import com.ssafy.mentionservice.feignclient.TeamServiceFeignClient;
import com.ssafy.mentionservice.jpa.*;
import com.ssafy.mentionservice.vo.CreateMentionRequestDto;
import com.ssafy.mentionservice.vo.MemberInfoDto;
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
    public MentionDetailResponseDto getMentionDetail(Long mentionId, Long memberId) {
        MentionEntity mention = mentionRepository.findById(mentionId)
                .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.MENTION_NOT_EXIST));
        MemberInfoDto memberInfo = memberServiceFeignClient.getMemberInfo(mention.getVoterId());
        int bang = memberServiceFeignClient.getMemberInfo(memberId).getBang();
        return MentionDetailResponseDto
                .builder()
                .hintStatus(mention.getHintStatus())
                .hintOne(mention.getHint())
                .hintTwo(getInitialSound(memberInfo.getNickname()))
                .hintThree(memberInfo.getNickname())
                .profileImg(memberInfo.getProfileImage())
                .bang(bang)
                .build();
    }

    @Override
    @Transactional
    public String plusHintstatus(Long mentionId) {
        MentionEntity mention = mentionRepository.findById(mentionId)
                .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.MENTION_NOT_EXIST));
        mention.plusHintstatus();
        return "힌트 단계 업!";
    }

    private String getInitialSound(String name) {
        String initialSound = "";
        String[] firstSound = {
                "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
        };

        for (int i = 0; i < name.length(); i++) {
            char ch = name.charAt(i);

            if (ch >= 0xAC00 && ch <= 0xD7A3) {
                int base = (ch - 0xAC00);
                int first = base / (21 * 28);
                initialSound += firstSound[first];
            } else {
                initialSound += ch;
            }
        }
        return initialSound;
    }

}
