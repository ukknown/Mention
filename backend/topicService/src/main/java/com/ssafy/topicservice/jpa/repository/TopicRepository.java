package com.ssafy.topicservice.jpa.repository;

import com.ssafy.topicservice.jpa.Entity.Topic;
import org.springframework.data.jpa.repository.JpaRepository;


public interface TopicRepository extends JpaRepository<Topic, Long> {

}
