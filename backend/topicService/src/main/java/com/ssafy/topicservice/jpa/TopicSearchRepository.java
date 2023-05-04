package com.ssafy.topicservice.jpa;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface TopicSearchRepository extends ElasticsearchRepository<TopicDocument, Long> {

}
