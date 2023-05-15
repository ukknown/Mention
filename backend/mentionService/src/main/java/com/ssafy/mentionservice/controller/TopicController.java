package com.ssafy.mentionservice.controller;

import com.ssafy.mentionservice.elastic.TopicDocument;
import com.ssafy.mentionservice.service.TopicService;
import com.ssafy.mentionservice.vo.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/topic-service")
@RequiredArgsConstructor
@Tag(name = "토픽 관리")
public class TopicController {

    private final TopicService topicService;
    @Operation(summary = "MSA 연결 체크")
    @GetMapping("/health-check")
    public String checkConnection(){
        return "TopicService Check Completed!";
    }


    @Operation(summary = "엘라스틱 repository에 저장", description = "데이터가 쌓이면 추후 메서드로 변경 예정")
    @PostMapping("/save/elastic")
    public void saveElastic() {
        topicService.saveElastic();
    }

    @Operation(summary = "엘라스틱 repository에서 삭제", description = "데이터가 쌓이면 추후 메서드로 변경 예정")
    @PostMapping("/delete/elastic")
    public void delete() {
        topicService.deleteElastic();
    }

    @Operation(summary = "토픽 검색", description = "초성단위로는 안됨")
    @GetMapping("/search")
    public ResponseEntity<List<TopicDocument>> searchByTitle(@RequestParam String title) {
        List<TopicDocument> documents = topicService.searchByTitle(title);
        return ResponseEntity.ok().body(documents);
    }

    @Operation(summary = "네이버 감정 분석 요청", description = "새로운 토픽일 경우 응모하시겠습니까? 이후 검증")
    @PostMapping("/check/naver-api")
    public ResponseEntity<String> goToNaver(HttpServletRequest request,
                                            @RequestBody TopicNaverRequestDto topicNaverRequestDto) {
        Long memberId = loadMember(request).getMemberId();
        return ResponseEntity.ok().body(topicService.goToNaver(topicNaverRequestDto, memberId));
    }

    @Operation(summary = "새로운 토픽인지 아닌지 검증", description = "새로운 토픽인지 아닌지 검증")
    @PostMapping("/check/similarity")
    public ResponseEntity<String> checkSimilarity(@RequestBody TopicTitleRequestDto topicTitleRequestDto) {
        return ResponseEntity.ok().body(topicService.checkSimilarity(topicTitleRequestDto.getTitle()));
    }

    @Operation(summary = "토픽 저장", description = "추후 데이터 쌓이면 메서드로 변환 예정")
    @PostMapping("/save/topic")
    public void saveTopic() {
        topicService.saveTopic();
    }

    @Operation(summary = "관리자가 응모리스트를 조회", description = "PENDING 상태인것만 반환")
    @GetMapping("/topics")
    public ResponseEntity<List<TopicResoponseDto>> getPendingTopic() {
        return ResponseEntity.ok().body(topicService.getPendingTopic());
    }


    @Operation(summary = "관리자가 응모 토픽을 승인", description = "APPROVE 상태로 변환")
    @PostMapping("/topics/approve")
    public ResponseEntity<?> approveTopic(@RequestBody TopicIdRequestDto topicIdRequestDto) {
        topicService.approveTopic(topicIdRequestDto.getTopicId());
        return ResponseEntity.ok().body("승인 완료");
    }

    @Operation(summary = "관리자가 응모 토픽을 거절", description = "REJECT 상태로 변환")
    @PostMapping("/topics/reject")
    public ResponseEntity<?> rejectTopic(@RequestBody TopicIdRequestDto topicIdRequestDto) {
        topicService.rejectTopic(topicIdRequestDto.getTopicId());
        return ResponseEntity.ok().body("거절 완료");
    }

    @GetMapping("/top-topic/{memberId}")
    public List<TopTopicVo> getTopTopic(@PathVariable Long memberId) {
        return topicService.getTopTopic(memberId);
    }

    @GetMapping("/topics/random/{teamId}")
    public ResponseEntity<TopicResoponseDto> getRandomTopic(@PathVariable Long teamId) {
        return ResponseEntity.ok().body(topicService.getRandomTopic(teamId));
    }

    private MemberVo loadMember(HttpServletRequest request) {
        JSONObject loginMember = new JSONObject(request.getHeader("member"));
        Long id = loginMember.getLong("id");
        String role = loginMember.getString("role");
        return MemberVo.builder()
                .memberId(id)
                .role(role)
                .build();
    }

}
