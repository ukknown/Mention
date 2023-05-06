package com.ssafy.topicservice.controller;

import com.ssafy.topicservice.jpa.TopicDocument;
import com.ssafy.topicservice.service.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @GetMapping("/elastic-search")
    public ResponseEntity<List<TopicDocument>> searchByTitle(@RequestParam String title) {
        List<TopicDocument> documents = topicService.searchByTitle(title);
        return ResponseEntity.ok().body(documents);
    }
}
