package com.ssafy.topicservice.jpa;

import com.ssafy.topicservice.jpa.Topic;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface TopicRepository extends JpaRepository<Topic, Long> {

    List<Topic> findAllByApproveStatus(ApproveStatus approveStatus);

//    Topic findTopByOrderByRandom();
}
