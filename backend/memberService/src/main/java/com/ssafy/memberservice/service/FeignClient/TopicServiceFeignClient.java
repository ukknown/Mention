package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient("/topic-service")
public interface TopicServiceFeignClient {

}
