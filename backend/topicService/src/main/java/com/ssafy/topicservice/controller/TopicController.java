package com.ssafy.topicservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/topic-service")
public class TopicController {

    @GetMapping("/health-check")
    public String checkConnection(){
        return "TopicService Check Completed!";
    }
}
