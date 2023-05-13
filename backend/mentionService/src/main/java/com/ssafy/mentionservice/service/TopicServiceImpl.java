package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.feignclient.MemberServiceFeignClient;
import com.ssafy.mentionservice.elastic.TopicDocument;
import com.ssafy.mentionservice.elastic.TopicSearchRepository;
import com.ssafy.mentionservice.exception.TopicExceptionEnum;
import com.ssafy.mentionservice.exception.TopicRuntimeException;
import com.ssafy.mentionservice.jpa.ApproveStatus;
import com.ssafy.mentionservice.jpa.TopicEntity;
import com.ssafy.mentionservice.jpa.TopicRepository;
import com.ssafy.mentionservice.vo.TopicResoponseDto;
import lombok.RequiredArgsConstructor;
import org.apache.commons.text.similarity.CosineSimilarity;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class TopicServiceImpl implements TopicService{

    private final TopicSearchRepository topicSearchRepository;
    private final TopicRepository topicRepository;
    private final MemberServiceFeignClient memberServiceFeignClient;

    @Value("${naver.app.key}")
    private String NAVER_KEY;

    @Value("${naver.app.secret}")
    private String NAVER_SECRET;

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
        // 결과값이 없으면 빈배열이 반환됨. 예외처리 안 하고, 프론트에서 결과값이 없습니다.. 하면 될 듯
        return topicSearchRepository.findByTitleContaining(title);
    }

    @Override
    @Transactional
    public String goToNaver(String topicCandidate, Long memberId) {
        try {
            WebClient webClient = WebClient.builder()
                .baseUrl("https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze")
                .defaultHeader("X-NCP-APIGW-API-KEY-ID", NAVER_KEY)
                .defaultHeader("X-NCP-APIGW-API-KEY", NAVER_SECRET)
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
                memberServiceFeignClient.addTimeout(memberId);
                return "부적절한 토픽입니다.";
            } else {
                TopicEntity topic = TopicEntity.builder()
                        .title(topicCandidate)
                        .approveStatus(ApproveStatus.PENDING)
                        .emoji("사용자가 넣은 이미지")
                        .build();
                topicRepository.save(topic);
                return "응모가 완료되었습니다.";
            }
        } catch (TopicRuntimeException e) {
            throw new TopicRuntimeException(TopicExceptionEnum.TOPIC_NAVER_EXCEPTION);
        }
    }

    @Override
    @Transactional
    public void saveTopic() {
        for (String title : titles) {
            TopicEntity topic = TopicEntity.builder()
                    .title(title)
                    .approveStatus(ApproveStatus.APPROVE)
                    .emoji("이모지 아직 없다")
                    .build();
            topicRepository.save(topic);
        }
    }

    @Override
    @Transactional
    public String checkSimilarity(String inputTopic) {
        List<TopicEntity> topicList = topicRepository.findAll();
        double threshold = 0.8;
        CosineSimilarity cosineSimilarity = new CosineSimilarity(); // 객체 생성

        for (TopicEntity topic : topicList) {
            Map<CharSequence, Integer> inputVector = getCharacterFrequencyVector(inputTopic);
            Map<CharSequence, Integer> topicVector = getCharacterFrequencyVector(topic.getTitle());
            double similarity = cosineSimilarity.cosineSimilarity(inputVector, topicVector);

            if (similarity >= threshold) {
                topic.addPopularity();
                return "이미 있는 문장입니다.";
            }
        }
        return "새로운 토픽입니다.";

    }

    @Override
    public List<TopicResoponseDto> getPendingTopic() {
        List<TopicEntity> topicList = topicRepository.findAllByApproveStatus(ApproveStatus.PENDING);
        return topicList.stream()
                .map(topic -> TopicResoponseDto.builder()
                        .id(topic.getId())
                        .title(topic.getTitle())
                        .approveStatus(topic.getApproveStatus())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void approveTopic(Long topicId) {
        TopicEntity topic = topicRepository.findById(topicId)
                .orElseThrow(()-> new TopicRuntimeException(TopicExceptionEnum.TOPIC_NOT_EXIST));
        topic.approveTopic();
        TopicDocument topicDocument = TopicDocument.builder()
                .id(topicSearchRepository.count()+1)
                .title(topic.getTitle())
                .build();
        topicSearchRepository.save(topicDocument);

    }

    @Override
    @Transactional
    public void rejectTopic(Long topicId) {
        TopicEntity topic = topicRepository.findById(topicId)
                        .orElseThrow(()-> new TopicRuntimeException(TopicExceptionEnum.TOPIC_NOT_EXIST));
        topic.rejectTopic();
    }

//    @Override
//    public TopicResoponseDto getRandomOne() {
//        Topic topic = topicRepository.findTopByOrderByRandom();
//
//    }
    private Map<CharSequence, Integer> getCharacterFrequencyVector(String text) {
        Map<CharSequence, Integer> vector = new HashMap<>();
        for (char c : text.toCharArray()) {
            CharSequence charSequence = String.valueOf(c);
            vector.put(charSequence, vector.getOrDefault(charSequence, 0) + 1);
        }
        return vector;
    }
}
