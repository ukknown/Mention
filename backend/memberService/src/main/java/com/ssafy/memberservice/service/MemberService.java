package com.ssafy.memberservice.service;


import com.ssafy.memberservice.vo.MemberVO;
import com.ssafy.memberservice.vo.dto.common.KakaoTokenResponseDto;
import com.ssafy.memberservice.vo.dto.response.MyPageVO;
import com.ssafy.memberservice.vo.dto.common.KakaoUserInfoResponseDto;
import com.ssafy.memberservice.vo.dto.response.TokenResponseDto;
import org.springframework.http.ResponseEntity;

public interface MemberService {

    KakaoUserInfoResponseDto getKakaoUser(String accessToken);

    ResponseEntity<TokenResponseDto> joinOrLoginC(String code);

    ResponseEntity<TokenResponseDto> joinOrLogin(String code);

    KakaoTokenResponseDto getKakaoToken(String code);
    

    MemberVO getMemberVO(Long memberid);

    void calBang(int bang, Long loginMemberId);

    void addTimeout(Long loginMemberId);

    boolean isBan(Long loginMemberId);

    MyPageVO getMypage(Long memberid);

    void deleteAccess(String bearerToken);
}
