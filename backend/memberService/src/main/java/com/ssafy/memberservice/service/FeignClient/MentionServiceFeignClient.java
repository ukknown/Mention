package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "mention-service", url ="http://localhost:8083/mention-service")
public interface MentionServiceFeignClient {



}
