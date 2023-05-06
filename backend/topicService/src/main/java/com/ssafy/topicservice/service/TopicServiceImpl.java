package com.ssafy.topicservice.service;

import com.ssafy.topicservice.jpa.Entity.ApproveStatus;
import com.ssafy.topicservice.jpa.TopicDocument;
import com.ssafy.topicservice.jpa.Entity.Topic;
import com.ssafy.topicservice.jpa.repository.TopicRepository;
import com.ssafy.topicservice.jpa.TopicSearchRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;


import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class TopicServiceImpl implements TopicService{

    private final TopicSearchRepository topicSearchRepository;
    private final TopicRepository topicRepository;

    String[] titles = {
            "내 이름 뜻", "생일", "키", "최근 관심사", "집에서 심심할 때 하는 일", "아침에 일어나서 제일 먼저 하는 일",
            "좋아하는 가수", "좋아하는 배우", "요즘 자주 듣는 노래", "인생 노래", "인생 드라마", "넷플릭스 추천",
            "좋아하는 음식", "싫어하는 음식", "이상형", "나랑 친해지는 법", "요즘 가장 하고싶은 것", "연하vs동갑vs연상",
            "내 목표(꿈, 장래희망)", "자기 전에 마지막으로 하는 일", "MBTI", "습관, 버릇", "취미", "특기(잘하는 것)",
            "좋아하는 계절", "낮, 밤 중 내가 가장 활발한 시간", "즐겨보는 유튜버", "좋아하는 색깔", "좋아하는 과일", "좋아하는 반찬",
            "지금 카톡 프사", "내 성격을 한 마디로 표현하면?", "가장 오래 연애한 기간", "가장 짧게 연애한 기간", "잠이 안올 때 하는 것",
            "좋아하는 라면", "답장 평균 시간", "아침식사 유무", "낯가림 유무", "단 음식 호, 불호", "매운 음식 호, 불호",
            "노래방 가면 항상 부르는 노래", "세상에서 가장 무서운 것", "민트초코 호, 불호", "가장 좋아하는 배라 맛", "전화 vs 문자",
            "스트레스 해소법", "인생 좌우명", "가장 많이 쓰는 카메라 어플", "최근 가장 웃겼던 말이나 짤", "내가 가진 것 중 가장 비싼 것",
            "내가 가진 것 중 가장 오래된 것", "내가 가진 것 중 가장 예쁜 것", "내가 가진 것 중 가장 쓸모없는 것", "가장 아끼는 물건"
    };
    @Override
    @Transactional
    public void saveElastic() {


        AtomicLong idCounter = new AtomicLong(1); // 새로운 ID 카운터 생성
        for (String title : titles) {
            TopicDocument topicDocument = TopicDocument.builder()
                    .id(idCounter.getAndIncrement())
                    .title(title)
                    .build();
            topicSearchRepository.save(topicDocument);
        }
    }

    @Override
    @Transactional
    public void deleteElastic() {
        topicSearchRepository.deleteAll();
    }

    @Override
    public List<TopicDocument> searchByTitle(String title) {
        return topicSearchRepository.findByTitleContaining(title);
    }

    @Override
    public String goToNaver(String topicCandidate) {
        WebClient webClient = WebClient.builder()
                .baseUrl("https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze")
                .defaultHeader("X-NCP-APIGW-API-KEY-ID", "deqlh0q577")
                .defaultHeader("X-NCP-APIGW-API-KEY", "F5cS6PM5v5AUjimYYLnl6Ioy5xfRKDk4oqC8jxOr")
                .build();

        Map<String, String> content = Map.of("content", topicCandidate);
        Mono<Map<String, Object>> responseMono = webClient.post()
                .contentType(MediaType.APPLICATION_JSON)
                .body(BodyInserters.fromValue(content))
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<Map<String, Object>>() {
                });

        Map<String, Object> response = responseMono.block();
        String sentiment = (String) ((Map<String, Object>) response.get("document")).get("sentiment");

        if (sentiment.equals("negative")) {
            // TODO member time out 추가
            return "부적절한 토픽입니다.";
        } else {
            Topic topic = Topic.builder()
                    .title(topicCandidate)
                    .approveStatus(ApproveStatus.PENDING)
                    .build();
            topicRepository.save(topic);
            return "응모가 완료되었습니다.";
        }
    }

    @Override
    @Transactional
    public void saveTopic() {
        for (String title : titles) {
            Topic topic = Topic.builder()
                    .title(title)
                    .approveStatus(ApproveStatus.APPROVE)
                    .build();
            topicRepository.save(topic);
        }
    }
}
