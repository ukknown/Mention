package com.ssafy.topicservice.jpa;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface TopicSearchRepository extends ElasticsearchRepository<TopicDocument, Long> {
    List<TopicDocument> findByTitleContaining(String title);
}
