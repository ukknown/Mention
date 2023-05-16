package com.ssafy.mentionservice.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "team-service")
public interface TeamServiceFeignClient {
    @GetMapping("/team-service/teams/count/members/{teamid}")
    int getTeamMemberCount(@PathVariable Long teamid);
}
