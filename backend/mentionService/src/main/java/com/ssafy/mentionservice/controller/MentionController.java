package com.ssafy.mentionservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mention-service")
public class MentionController {
    @GetMapping("/health-check")
    public String checkConnection(){
        return "MentionService Check Completed!";
    }
}
