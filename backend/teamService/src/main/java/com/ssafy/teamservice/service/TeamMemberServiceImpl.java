package com.ssafy.teamservice.service;

import com.ssafy.teamservice.client.MentionServiceClient;
import com.ssafy.teamservice.jpa.TeamMemberEntity;
import com.ssafy.teamservice.jpa.TeamMemberRepository;
import com.ssafy.teamservice.vo.TeamMemberVO;
import com.ssafy.teamservice.vo.TeamVO;
import com.ssafy.teamservice.vo.dto.TeamResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeamMemberServiceImpl implements TeamMemberService{
    private final TeamMemberRepository teamMemberRepository;
    private final MentionServiceClient mentionServiceClient;

    /**
     * team_member(그룹)에 이미 가입한 적이 있는지 확인
     * @param teamMemberVO
     * @return
     */
    @Override
    public boolean existsByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO) {
        return teamMemberRepository.existsByMemberIdAndTeamEntity(teamMemberVO.getMemberId(), teamMemberVO.getTeamEntity());
    }

    /**
     * 아이디로 TeamMemberEntity 조회
     * @param teamMemberVO
     * @return
     */
    @Override
    public TeamMemberEntity findByMemberIdAndTeamEntity(TeamMemberVO teamMemberVO) {
        return teamMemberRepository.findByMemberIdAndTeamEntity(teamMemberVO.getMemberId(), teamMemberVO.getTeamEntity());
    }

    /**
     * 그룹 참여(저장)
     * @param teamMemberVO
     */
    @Override
    public void joinTeamMember(TeamMemberVO teamMemberVO) {
        TeamMemberEntity teamMemberEntity = TeamMemberEntity.builder()
                .teamEntity(teamMemberVO.getTeamEntity())
                .memberId(teamMemberVO.getMemberId())
                .build();
        teamMemberRepository.save(teamMemberEntity);
    }

    /**
     * 회원이 속한 그룹 정보(기본 정보 + 투표 정보) 조회
     * @param memberId
     * @return
     */
    @Override
    public List<TeamResponseDto> getTeamList(Long memberId) {
        List<TeamMemberEntity> teamMemberEntityList = teamMemberRepository.findTeamMemberEntityByMemberId(memberId);

        return teamMemberEntityList.stream()
                .filter(teamMember -> teamMember.getTeamEntity().getIsDeleted() == 0 && teamMember.getIsKickOut() == 0)
                .map(teamMember ->
                        new TeamResponseDto(teamMember.getTeamEntity(),
                                mentionServiceClient.getVoteList(teamMember.getTeamEntity().getId(), memberId, "TWO")
                        )
                )
                .collect(Collectors.toList());
    }

    @Override
    public void updateIsKickOut(TeamMemberVO teamMemberVO) {
        TeamMemberEntity teamMemberEntity = findByMemberIdAndTeamEntity(teamMemberVO);
        teamMemberEntity.updateIsKickOut();
    }

    @Override
    public int getTeamCount(Long memberId) {
        return teamMemberRepository.getTeamCount(memberId);
    }

    @Override
    public List<Long> getTeamMembers(TeamVO teamVO) {
        return teamMemberRepository.getTeamMemberListById(teamVO.getTeamId());
    }

    /**
     * 그룹에서 회원 삭제
     * @param teamMemberVO
     */
    @Override
    public void deleteMemberFromTeam(TeamMemberVO teamMemberVO) {
        TeamMemberEntity teamMemberEntity = findByMemberIdAndTeamEntity(teamMemberVO);
        teamMemberRepository.deleteById(teamMemberEntity.getId());
    }


}
