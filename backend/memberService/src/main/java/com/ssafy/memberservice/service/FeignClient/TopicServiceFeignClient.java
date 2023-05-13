package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "topic-service", url ="http://localhost:8085/topic-service")
public interface TopicServiceFeignClient {

    //나를 가장 많이 멘션한 토픽
    @GetMapping("/topic-service/top-topic/{memberid}")
    String getTopTopic(@PathVariable  Long memberid);


}
