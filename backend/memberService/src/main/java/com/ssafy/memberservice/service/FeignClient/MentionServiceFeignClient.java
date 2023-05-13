package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "mention-service", url ="http://localhost:8083/mention-service")
public interface MentionServiceFeignClient {

    //나를 가장 많이 멘션한 토픽의 멘션 수
    @GetMapping("/mention-count")
        Integer getMentionCount(Long memberid);

}
