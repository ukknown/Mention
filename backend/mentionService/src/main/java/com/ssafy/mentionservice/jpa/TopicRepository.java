package com.ssafy.mentionservice.jpa;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface TopicRepository extends JpaRepository<TopicEntity, Long> {

    List<TopicEntity> findAllByApproveStatus(ApproveStatus approveStatus);

    List<TopicEntity> findByIdNotIn(List<Long> topicIds);

}
