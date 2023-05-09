package com.ssafy.topicservice.controller;

import com.ssafy.topicservice.elastic.TopicDocument;
import com.ssafy.topicservice.service.TopicService;
import com.ssafy.topicservice.vo.TopicResoponseDto;
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

    // elastic 저장 토픽 정해지면 토픽이 업데이트 되면 이 부분도 업데이트
    @PostMapping("/save/elastic")
    public void saveElastic() {
        topicService.saveElastic();
    }

    // elastic 삭제  , 저장과 마찬가지로 jpa 업데이트 될 때 해당
    @PostMapping("/delete/elastic")
    public void delete() {
        topicService.deleteElastic();
    }

    // 토픽 검색
    @GetMapping("/elastic-search")
    public ResponseEntity<List<TopicDocument>> searchByTitle(@RequestParam String title) {
        List<TopicDocument> documents = topicService.searchByTitle(title);
        return ResponseEntity.ok().body(documents);
    }

    //감정 분석 요청
    @PostMapping("/call/naver")
    public ResponseEntity<String> goToNaver(@RequestBody Map<String, String> topicCandidate) {
        return ResponseEntity.ok().body(topicService.goToNaver(topicCandidate.get("topicCandidate")));
    }

    //유사도 검사 요청
    @PostMapping("/check/similarity")
    public ResponseEntity<String> checkSimilarity(@RequestBody Map<String, String> inputTopic) {
        return ResponseEntity.ok().body(topicService.checkSimilarity(inputTopic.get("inputTopic")));
    }

    //토픽 저장
    @PostMapping("/save/topic")
    public void saveTopic() {
        topicService.saveTopic();
    }

    // 관리자가 토픽 응모 리스트 조회
    @GetMapping("/admin/pendingList")
    public ResponseEntity<List<TopicResoponseDto>> getPendingTopic() {
        return ResponseEntity.ok().body(topicService.getPendingTopic());
    }

    //관리자가 승인
    @PostMapping("/admin/changeStatus/approve")
    public ResponseEntity<?> approveTopic(@RequestBody Map<String, Long> topicId) {
        topicService.approveTopic(topicId.get("topicId"));
        return ResponseEntity.ok().body("승인 완료");
    }

    //관리자가 거절
    @PostMapping("/admin/changeStatus/reject")
    public ResponseEntity<?> rejectTopic(@RequestBody Map<String, Long> topicId) {
        topicService.rejectTopic(topicId.get("topicId"));
        return ResponseEntity.ok().body("거절 완료");
    }

//    @GetMapping("/random/one/{teamId}")
//    public ResponseEntity<TopicResoponseDto> getRandomOne() {
//        return ResponseEntity.ok().body(topicService.getRandomOne());
//    }

}
