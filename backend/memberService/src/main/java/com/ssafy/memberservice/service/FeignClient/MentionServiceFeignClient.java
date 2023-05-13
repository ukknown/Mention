package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "mention-service")
public interface MentionServiceFeignClient {

}
