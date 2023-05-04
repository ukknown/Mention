package com.ssafy.teamservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/team-service")
public class TeamController {
    @GetMapping("/health-check")
    public String checkConnection(){
        return "Team MicroService Check Completed!";
    }
}
