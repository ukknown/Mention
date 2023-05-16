package com.ssafy.mentionservice.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "notification-service")
public interface NotificationServiceFeignClient {
    @GetMapping("/notification-service/mention/{memberid}/{mentionid}/{gender}")
    ResponseEntity createVoteOpenNotification(
            @PathVariable("memberid") Long memberId
            ,@PathVariable("mentionid") Long mentionId
            ,@PathVariable("gender") String gender
    );


}
