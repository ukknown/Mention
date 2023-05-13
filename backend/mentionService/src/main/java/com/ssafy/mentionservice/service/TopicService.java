package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.elastic.TopicDocument;
import com.ssafy.mentionservice.vo.TopicResoponseDto;

import java.util.List;

public interface TopicService {

    void saveElastic();

    void deleteElastic();

    List<String> getDailyTopic();

    void setDailyTopic();

    String goToNaver(String topicCandidate, Long memberId);

    List<TopicDocument> searchByTitle(String title);

    String checkSimilarity(String inputTopic);

    void saveTopic();

    List<TopicResoponseDto> getPendingTopic();

    void approveTopic(Long topicId);

    void rejectTopic(Long topicId);

//    TopicResoponseDto getRandomOne();
}
