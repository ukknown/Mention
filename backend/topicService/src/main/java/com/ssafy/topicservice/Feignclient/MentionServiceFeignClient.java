package com.ssafy.topicservice.Feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;



@FeignClient(name = "mention-service")
public interface MentionServiceFeignClient {

    @GetMapping("/mention-service/health-check")
    String checkFeign();

}