package com.ssafy.mentionservice.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "notification-service")
public interface NotificationServiceFeignClient {
    @GetMapping("/notification-service/mention/{memberid}/{mentionid}/{gender}")
    ResponseEntity createMentionNotification(
            @PathVariable("memberid") Long memberId
            ,@PathVariable("mentionid") Long mentionId
            ,@PathVariable("gender") String gender
    );
    @GetMapping("/notification-service/topic-winner/{memberid}/{topicid}")
    ResponseEntity createTopicWinnerNotification(
            @PathVariable("memberid") Long memberId
            ,@PathVariable("topicid") Long topicId
    );

    @GetMapping("/notification-service/vote-open/{teamid}/{memberid}/{voteid}")
    ResponseEntity createVoteOpenNotification(@PathVariable("teamid") Long teamId, @PathVariable("memberid") Long memberId, @PathVariable("voteid") Long voteId);
}
