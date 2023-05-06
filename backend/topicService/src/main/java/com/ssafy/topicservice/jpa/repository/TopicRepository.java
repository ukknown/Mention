package com.ssafy.topicservice.jpa.repository;

import com.ssafy.topicservice.jpa.Entity.Topic;
import org.springframework.data.repository.CrudRepository;

public interface TopicRepository extends CrudRepository<Topic, Long> {

}
