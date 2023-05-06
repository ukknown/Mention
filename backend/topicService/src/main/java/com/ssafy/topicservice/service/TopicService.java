package com.ssafy.topicservice.service;

import com.ssafy.topicservice.jpa.TopicDocument;

import java.util.List;

public interface TopicService {

    void saveElastic();

    void deleteElastic();

    List<TopicDocument> searchByTitle(String title);
}
