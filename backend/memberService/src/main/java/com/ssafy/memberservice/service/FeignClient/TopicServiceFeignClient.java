package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "topic-service", url ="http://localhost:8085/topic-service")
public interface TopicServiceFeignClient {

}
