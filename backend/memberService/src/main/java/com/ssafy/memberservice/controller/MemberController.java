package com.ssafy.memberservice.controller;

import com.ssafy.memberservice.service.MemberService;

import com.ssafy.memberservice.vo.dto.response.TokenResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/member-service")
public class MemberController {
    private final MemberService memberService;

    @PostMapping("/login")
    public ResponseEntity<TokenResponseDto> getKakao(@RequestBody Map<String, String> code) {
        return memberService.joinOrLogin(code.get("code"));
    }
    @GetMapping("/health-check")
    public String checkConnection(){

        return "MemberService Check Completed!";
    }

    //타임아웃 횟수 추가
    @PostMapping("/time-out")
    public void addCount(@RequestBody String useremail){
        memberService.addCount(useremail);
    }

}
