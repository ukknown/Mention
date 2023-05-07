package com.ssafy.topicservice.controller;

import com.ssafy.topicservice.elastic.TopicDocument;
import com.ssafy.topicservice.service.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @PostMapping("/call/naver")
    public ResponseEntity<String> goToNaver(@RequestBody Map<String, String> topicCandidate) {
        return ResponseEntity.ok().body(topicService.goToNaver(topicCandidate.get("topic")));
    }

    @PostMapping("/check/similarity")
    public ResponseEntity<String> checkSimilarity(@RequestBody Map<String, String> inputTopic) {
        return ResponseEntity.ok().body(topicService.checkSimilarity(inputTopic.get("topic")));
    }

    @PostMapping("/save/topic")
    public void saveTopic() {
        topicService.saveTopic();
    }

    @GetMapping("/admin/pendingList")
    public ResponseEntity<?> getPendingTopic() {
        return ResponseEntity.ok().body(topicService.getPendingTopic());
    }

}
