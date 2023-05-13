package com.ssafy.teamservice.client;

import com.ssafy.teamservice.vo.MemberVO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "member-service")
public interface MemberServiceClient {
    @GetMapping("/member-service/{memberid}")
    MemberVO getMembers(@PathVariable Long memberid);
}
