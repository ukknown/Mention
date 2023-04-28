package com.ssafy.mention.controller;

import com.ssafy.mention.dto.common.KakaoTokenResponse;
import com.ssafy.mention.dto.common.KakaoUserInfoResponse;
import com.ssafy.mention.dto.response.TokenResponse;
import com.ssafy.mention.jwt.JwtTokenProvider;
import com.ssafy.mention.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final JwtTokenProvider jwtTokenProvider;
    @PostMapping("/login")
    public ResponseEntity<TokenResponse> getKakao(@RequestBody Map<String, String> code) {
        return memberService.joinOrLogin(code.get("code"));
    }

    @PostMapping("/refresh")
    public ResponseEntity<TokenResponse> refresh(@RequestHeader(value="Authorization") String refreshToken,
                                                 @RequestBody Map<String, String> email) {
        return memberService.refresh(refreshToken, email.get("email"));
    }

    @GetMapping("/test")
    public String test() {
        return "hello";
    }

}
