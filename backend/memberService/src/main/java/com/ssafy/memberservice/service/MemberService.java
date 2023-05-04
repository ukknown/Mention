package com.ssafy.memberservice.service;

import com.ssafy.memberservice.vo.dto.common.KakaoTokenResponse;
import com.ssafy.memberservice.vo.dto.common.KakaoUserInfoResponse;
import com.ssafy.memberservice.vo.dto.response.TokenResponse;
import org.springframework.http.ResponseEntity;

public interface MemberService {
    KakaoTokenResponse getKakaoToken(String code);

    KakaoUserInfoResponse getKakaoUser(String accessToken);

    ResponseEntity<TokenResponse> refresh(String refreshToken, String email);

    ResponseEntity<TokenResponse> joinOrLogin(String code);
}
