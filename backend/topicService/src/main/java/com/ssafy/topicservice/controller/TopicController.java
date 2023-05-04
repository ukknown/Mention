package com.ssafy.topicservice.controller;

import com.ssafy.topicservice.service.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/topic-service")
@RequiredArgsConstructor
public class TopicController {

    private final TopicService topicService;
    @GetMapping("/health-check")
    public String checkConnection(){
        return "TopicService Check Completed!";
    }

    @PostMapping("/save/elastic")
    public void saveElastic() {
        topicService.saveElastic();
    }

    @PostMapping("/delete/elastic")
    public void delete() {
        topicService.deleteElastic();
    }
}
