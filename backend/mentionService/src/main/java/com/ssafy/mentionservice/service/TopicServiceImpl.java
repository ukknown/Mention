package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.feignclient.MemberServiceFeignClient;
import com.ssafy.mentionservice.elastic.TopicDocument;
import com.ssafy.mentionservice.elastic.TopicSearchRepository;
import com.ssafy.mentionservice.exception.MentionServiceExceptionEnum;
import com.ssafy.mentionservice.exception.MentionServiceRuntimeException;
import com.ssafy.mentionservice.feignclient.NotificationServiceFeignClient;
import com.ssafy.mentionservice.jpa.*;
import com.ssafy.mentionservice.vo.TopTopicVo;
import com.ssafy.mentionservice.vo.TopicNaverRequestDto;
import com.ssafy.mentionservice.vo.TopicResoponseDto;
import lombok.RequiredArgsConstructor;
import org.apache.commons.text.similarity.CosineSimilarity;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
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
    private final MentionRepository mentionRepository;
    private final TopicRepository topicRepository;
    private final MemberServiceFeignClient memberServiceFeignClient;
    private final VoteRepository voteRepository;
    private final NotificationServiceFeignClient notificationServiceFeignClient;

    @Value("${naver.app.key}")
    private String NAVER_KEY;

    @Value("${naver.app.secret}")
    private String NAVER_SECRET;

    @Override
    @Transactional
    public void saveElastic() {
        AtomicLong idCounter = new AtomicLong(1);
        List<TopicEntity> topics = topicRepository.findAll();
        for (TopicEntity topic : topics) {
            TopicDocument topicDocument = TopicDocument.builder()
                    .id(idCounter.getAndIncrement())
                    .title(topic.getTitle())
                    .emoji(topic.getEmoji())
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
    public String goToNaver(TopicNaverRequestDto topicNaverRequestDto, Long memberId) {
        try {
            WebClient webClient = WebClient.builder()
                .baseUrl("https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze")
                .defaultHeader("X-NCP-APIGW-API-KEY-ID", NAVER_KEY)
                .defaultHeader("X-NCP-APIGW-API-KEY", NAVER_SECRET)
                .build();

            String topicCandidate = topicNaverRequestDto.getTitle();
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
                        .isSystem(false)
                        .winnerId(memberId)
                        .emoji("사용자가 넣은 이미지")
                        .build();
                topicRepository.save(topic);
                return "응모가 완료되었습니다.";
            }
        } catch (MentionServiceRuntimeException e) {
            throw new MentionServiceRuntimeException(MentionServiceExceptionEnum.TOPIC_NAVER_EXCEPTION);
        }
    }

    public List<TopTopicVo> getTopTopic(Long memberId) {
        List<MentionEntity> mentions = mentionRepository.findAllByPickerIdOrderByVoteIdAsc(memberId);

        Map<Long, Long> voteIdCounts = mentions.stream()
                .collect(Collectors.groupingBy(m -> m.getVote().getId(), Collectors.counting()));

        List<Long> topVoteIds = voteIdCounts.entrySet().stream()
                .sorted(Map.Entry.<Long, Long>comparingByValue().reversed())
                .limit(3)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        List<TopTopicVo> topTopics = new ArrayList<>();
        for (Long voteId : topVoteIds) {
            VoteEntity vote = voteRepository.findById(voteId)
                    .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.VOTE_NOT_EXIST));
            TopicEntity topic = vote.getTopic();
            TopTopicVo vo = TopTopicVo
                    .builder()
                    .topicId(topic.getId())
                    .topicTitle(topic.getTitle())
                    .mentionCount(voteIdCounts.get(voteId))
                    .build();
            topTopics.add(vo);
        }
        return topTopics;
    }

//    @Override
//    @Transactional
//    public void saveTopic() {
//        for (String title : titles) {
//            TopicEntity topic = TopicEntity.builder()
//                    .title(title)
//                    .approveStatus(ApproveStatus.APPROVE)
//                    .emoji("이모지 아직 없다")
//                    .build();
//            topicRepository.save(topic);
//        }
//    }

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
                        .emoji(topic.getEmoji())
                        .build())
                .collect(Collectors.toList());
    }


    @Override
    @Transactional
    public void approveTopic(Long topicId) {
        TopicEntity topic = topicRepository.findById(topicId)
                .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.TOPIC_NOT_EXIST));
        topic.approveTopic();
        TopicDocument topicDocument = TopicDocument.builder()
                .id(topicSearchRepository.count()+1)
                .title(topic.getTitle())
                .build();
        topicSearchRepository.save(topicDocument);
        notificationServiceFeignClient.createTopicWinnerNotification(topic.getWinnerId(), topic.getId());
    }

    @Override
    @Transactional
    public void rejectTopic(Long topicId) {
        TopicEntity topic = topicRepository.findById(topicId)
                        .orElseThrow(()-> new MentionServiceRuntimeException(MentionServiceExceptionEnum.TOPIC_NOT_EXIST));
        topic.rejectTopic();
    }

    @Override
    public TopicResoponseDto getRandomTopic(Long teamId) {
        List<VoteEntity> votes = voteRepository.findAllByTeamIdAndIsCompletedIsFalse(teamId);
        List<Long> topicIds = votes.stream()
                .map(vote -> vote.getTopic().getId())
                .collect(Collectors.toList());
        List<TopicEntity> topics = topicRepository.findByIdNotIn(topicIds);
        if (!topics.isEmpty()) {
            Random random = new Random();
            TopicEntity randomTopic = topics.get(random.nextInt(topics.size()));
            return TopicResoponseDto.builder()
                    .id(randomTopic.getId())
                    .title(randomTopic.getTitle())
                    .emoji(randomTopic.getEmoji())
                    .build();
        }
        throw new MentionServiceRuntimeException(MentionServiceExceptionEnum.ALL_TOPIC_DONE);
    }

    @Override
    public String getTopicByTopicId(Long topicId) {
        TopicEntity topic = topicRepository.findById(topicId)
                .orElseThrow(() -> new MentionServiceRuntimeException(MentionServiceExceptionEnum.TOPIC_NOT_EXIST));
        return topic.getTitle();
    };


    private Map<CharSequence, Integer> getCharacterFrequencyVector(String text) {
        Map<CharSequence, Integer> vector = new HashMap<>();
        for (char c : text.toCharArray()) {
            CharSequence charSequence = String.valueOf(c);
            vector.put(charSequence, vector.getOrDefault(charSequence, 0) + 1);
        }
        return vector;
    }
}
