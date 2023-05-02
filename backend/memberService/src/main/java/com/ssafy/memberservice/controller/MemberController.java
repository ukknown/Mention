package com.ssafy.memberservice.controller;

import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member-service")
public class MemberController {
    private final Environment env;

    public MemberController(Environment env) {
        this.env = env;
    }

    @GetMapping("/health-check")
    public String checkConnection(){
        return "MemberService Check Completed!" + env.getProperty("greeting.message");
    }

}
