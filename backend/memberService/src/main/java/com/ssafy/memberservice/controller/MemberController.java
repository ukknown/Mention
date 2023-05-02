package com.ssafy.memberservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member-service")
public class MemberController {
    @GetMapping("/health-check")
    public String checkConnection(){
        return "MemberService Check Completed!";
    }

}
