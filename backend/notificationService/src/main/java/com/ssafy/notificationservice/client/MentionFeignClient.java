package com.ssafy.notificationservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "mention-service")
public interface MentionFeignClient {
    @GetMapping("/topic-service/topics/topic-title/{topicid}")
    String getTopicTitleByTopicId(@PathVariable("topicid") Long topicId);
    @GetMapping("/mention-service/mentions/topic-title/{mentionid}")
    String getTopicTitleByMentionId(@PathVariable("mentionid") Long mentionId);
    @GetMapping("/mention-service/votes/topic-title/{voteid}")
    String getTopicTitleByVoteId(@PathVariable("voteid") Long voteId);
}