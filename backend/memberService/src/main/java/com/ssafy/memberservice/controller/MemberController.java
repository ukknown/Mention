package com.ssafy.memberservice.controller;

import com.ssafy.memberservice.service.MemberService;

import com.ssafy.memberservice.vo.dto.response.TokenResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/member-service")
public class MemberController {
    private final MemberService memberService;

    @PostMapping("/login")
    public ResponseEntity<TokenResponseDto> getKakao(@RequestBody Map<String, String> code) {
        System.out.println("/login bodycode : "+ code.get("code"));
        return memberService.joinOrLogin(code.get("code"));
    }

    //gateway에서 오는 정보 확인
    @GetMapping("/health-check")
    public String checkConnection(HttpServletRequest request){
        String memberStr = request.getHeader("member");

        System.out.println(memberStr);

        return "MemberService Check Completed!";
    }

    //타임아웃 횟수 추가
    @PostMapping("/time-out")
    public void addCount(HttpServletRequest request){
        String memberStr = request.getHeader("member");

        System.out.println(memberStr);

    }



}
