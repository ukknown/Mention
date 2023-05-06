package com.ssafy.topicservice.service;

import com.ssafy.topicservice.jpa.TopicDocument;

import java.util.List;

public interface TopicService {

    void saveElastic();

    void deleteElastic();

    String goToNaver(String topicCandidate);

    List<TopicDocument> searchByTitle(String title);

    void saveTopic();
}
