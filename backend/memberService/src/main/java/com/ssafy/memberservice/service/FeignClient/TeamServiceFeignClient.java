package com.ssafy.memberservice.service.FeignClient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "team-service")
public interface TeamServiceFeignClient {

    @GetMapping("/GroupCount/{memberid}")
    Integer getGroupCount(@PathVariable Long memberid);

}
