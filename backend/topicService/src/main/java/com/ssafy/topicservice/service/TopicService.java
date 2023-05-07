package com.ssafy.topicservice.service;

import com.ssafy.topicservice.elastic.TopicDocument;
import com.ssafy.topicservice.vo.PendingTopicResoponseDto;

import java.util.List;

public interface TopicService {

    void saveElastic();

    void deleteElastic();

    String goToNaver(String topicCandidate);

    List<TopicDocument> searchByTitle(String title);

    String checkSimilarity(String inputTopic);

    void saveTopic();

    List<PendingTopicResoponseDto> getPendingTopic();

    void approveTopic(Long topicId);
}
