package com.ssafy.memberservice.service;


import com.ssafy.memberservice.vo.dto.common.KakaoTokenResponseDto;
import com.ssafy.memberservice.vo.dto.common.KakaoUserInfoResponseDto;
import com.ssafy.memberservice.vo.dto.response.TokenResponseDto;
import org.springframework.http.ResponseEntity;

public interface MemberService {
    KakaoTokenResponseDto getKakaoToken(String code);

    KakaoUserInfoResponseDto getKakaoUser(String accessToken);


    ResponseEntity<TokenResponseDto> joinOrLogin(String code);

    void addCount(String useremail);
}
