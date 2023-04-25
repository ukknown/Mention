package com.ssafy.mention.service;

import com.ssafy.mention.dto.common.KakaoTokenResponse;
import com.ssafy.mention.dto.common.KakaoUserInfoResponse;
import com.ssafy.mention.dto.response.TokenResponse;
import org.springframework.http.ResponseEntity;

public interface MemberService {
    KakaoTokenResponse getKakaoToken(String code);

    KakaoUserInfoResponse getKakaoUser(String accessToken);

    ResponseEntity<TokenResponse> joinOrLogin(String code);
}
