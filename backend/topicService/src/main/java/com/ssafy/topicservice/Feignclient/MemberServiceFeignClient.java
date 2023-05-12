package com.ssafy.topicservice.Feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;


@FeignClient(name = "member-service", url = "http://localhost:8081/member-service")
public interface MemberServiceFeignClient {
    @GetMapping("/time-out")
    public ResponseEntity addTimeout(@RequestParam Long memberId);
}