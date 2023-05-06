package com.ssafy.topicservice.jpa;

import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface TopicSearchRepository extends ElasticsearchRepository<TopicDocument, Long> {
    @Query("{\"match_phrase_prefix\": {\"title\": {\"query\": \"?0\"}}}")
    List<TopicDocument> findByTitle(String title);
}
