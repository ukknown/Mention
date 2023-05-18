package com.ssafy.teamservice.service;

import com.ssafy.teamservice.client.MemberServiceClient;
import com.ssafy.teamservice.client.MentionServiceClient;
import com.ssafy.teamservice.jpa.TeamEntity;
import com.ssafy.teamservice.jpa.TeamMemberRepository;
import com.ssafy.teamservice.jpa.TeamRepository;
import com.ssafy.teamservice.utils.RandomCodeGenerator;
import com.ssafy.teamservice.utils.error.ErrorCode;
import com.ssafy.teamservice.utils.exception.CustomException;
import com.ssafy.teamservice.vo.MemberVO;
import com.ssafy.teamservice.vo.VoteVO;
import com.ssafy.teamservice.vo.dto.TeamDetailsResponseDto;
import com.ssafy.teamservice.vo.TeamDetailVO;
import com.ssafy.teamservice.vo.TeamVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService{
    private final RandomCodeGenerator randomCodeGenerator;
    private final TeamRepository teamRepository;
    private final TeamMemberRepository teamMemberRepository;
    private final MemberServiceClient memberServiceClient;
    private final MentionServiceClient mentionServiceClient;


    /**
     * 그룹(팀) 생성
     * @param teamDetailVO
     * @return
     */
    @Override
    public TeamEntity createTeam(TeamDetailVO teamDetailVO) {
        int randomCode;

        while(true){
            randomCode = randomCodeGenerator.generate();
            if(teamRepository.findByCode(randomCode) == null) break;
        }

        TeamEntity teamEntity = TeamEntity.builder()
                .name(teamDetailVO.getName())
                .image(teamDetailVO.getImage())
                .capacity(teamDetailVO.getCapacity())
                .isDeleted(teamDetailVO.getIsDeleted())
                .code(randomCode)
                .teamOwnerId(teamDetailVO.getTeamOwnerId())
                .build();

        teamRepository.save(teamEntity);
        return teamEntity;
    }

    /**
     * 팀 상세정보 엔티티 조회
     * @param teamVO
     * @return
     */
    @Override
    public TeamEntity findById(TeamVO teamVO) {
        return teamRepository.findById(teamVO.getTeamId())
                .orElseThrow(() -> new CustomException(ErrorCode.MEMBER_NOT_FOUND));
    }

    @Override
    public int updateCapacity(TeamVO teamVO, boolean isIn) {
        TeamEntity teamEntity = findById(teamVO);
        if(isIn) {
            teamEntity.updateCapacity(teamEntity.getCapacity() + 1);
            return teamEntity.getCapacity() + 1;
        } else {
            teamEntity.updateCapacity(teamEntity.getCapacity() - 1);
            return teamEntity.getCapacity() - 1;
        }
    }

    @Override
    public void updateIsDeleteTrue(TeamVO teamVO) {
        TeamEntity teamEntity = findById(teamVO);
        teamEntity.updateIsDelete();
    }

    @Override
    public String getTeamName(TeamVO teamVO) {
        return teamRepository.getTeamNameById(teamVO.getTeamId());
    }

    @Override
    public int getTeamMemberCount(TeamVO teamVO) {
        return teamRepository.getTeamMemberById(teamVO.getTeamId());
    }

    @Override
    public TeamEntity findTeamByTeamCode(int code) {
        TeamEntity teamEntity = teamRepository.findByCode(code);
        if(teamEntity == null) {
            throw new CustomException(ErrorCode.TEAM_NOT_FOUND);
        }
        return teamEntity;
    }

    /**
     * 팀 상세정보 조회
     * @param teamVO
     * @return
     */
    @Override
    public TeamDetailsResponseDto getTeamDetails(TeamVO teamVO) {
        TeamEntity teamEntity = findById(teamVO);

        if(teamEntity.getIsDeleted() == 1) {
            throw new CustomException(ErrorCode.TEAM_NOT_FOUND);
        }

        List<Long> memberList = teamMemberRepository.getMemberByTeamEntity(teamEntity);

        // List<Long> -> List<MemberVO> 로 만들기
        List<MemberVO> memberResultList = memberList.stream()
                .map(memberId -> memberServiceClient.getMembers(memberId))
                .collect(Collectors.toList());

        // 투표 리스트 조회
        List<VoteVO> voteList = mentionServiceClient.getVoteList(teamVO.getTeamId(), (long) teamVO.getMemberId(), "ALL");

        return new TeamDetailsResponseDto(teamEntity, memberResultList, voteList);
    }

    /**
     * 팀 아이디 존재 여부 확인
     * @param teamVO
     * @return
     */
    @Override
    public boolean existsById(TeamVO teamVO) {
        return teamRepository.existsById(teamVO.getTeamId());
    }
}
