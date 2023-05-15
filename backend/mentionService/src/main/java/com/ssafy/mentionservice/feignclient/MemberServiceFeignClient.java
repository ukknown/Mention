package com.ssafy.mentionservice.feignclient;

import com.ssafy.mentionservice.vo.MemberInfoDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


@FeignClient(name = "member-service")
public interface MemberServiceFeignClient {
    @GetMapping("/member-service/feign/time-out")
    ResponseEntity addTimeout(@RequestParam Long memberId);
    @GetMapping("/member-service/feign/member-info/{memberid}")
    MemberInfoDto getMemberInfo(@PathVariable Long memberid);
}