package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient("/mention-service")
public interface MentionServiceFeignClient {



}
