package com.ssafy.mentionservice.service;

import com.ssafy.mentionservice.elastic.TopicDocument;
import com.ssafy.mentionservice.vo.TopTopicVo;
import com.ssafy.mentionservice.vo.TopicNaverRequestDto;
import com.ssafy.mentionservice.vo.TopicResoponseDto;

import java.util.List;

public interface TopicService {

    void saveElastic();

    void deleteElastic();

    String goToNaver(TopicNaverRequestDto topicNaverRequestDto, Long memberId);

    List<TopicDocument> searchByTitle(String title);

    String checkSimilarity(String inputTopic);

//    void saveTopic();

    List<TopTopicVo> getTopTopic(Long memberId);

    List<TopicResoponseDto> getPendingTopic();

    void approveTopic(Long topicId);

    void rejectTopic(Long topicId);
    String getTopicByTopicId(Long topicId);
    TopicResoponseDto getRandomTopic(Long teamId);
}
