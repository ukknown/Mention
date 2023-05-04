package com.ssafy.memberservice.controller;

import com.ssafy.memberservice.jwt.JwtTokenProvider;
import com.ssafy.memberservice.service.MemberService;
import com.ssafy.memberservice.vo.dto.response.TokenResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/member-service")
@RequiredArgsConstructor
public class MemberController {
    private final Environment env;
    private final MemberService memberService;
    private final JwtTokenProvider jwtTokenProvider;

//    public MemberController(Environment env) {
//        this.env = env;
//    }

    @PostMapping("/login")
    public ResponseEntity<TokenResponse> getKakao(@RequestBody Map<String, String> code) {
        return memberService.joinOrLogin(code.get("code"));
    }


    @GetMapping("/health-check")
    public String checkConnection(){
        return "MemberService Check Completed!" + env.getProperty("greeting.message");
    }

}
