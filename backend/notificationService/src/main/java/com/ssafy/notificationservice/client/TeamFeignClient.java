package com.ssafy.notificationservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "team-service")
public interface TeamFeignClient {
    @GetMapping("/team-service/teams/info/{teamid}")
    String getTeamName(@PathVariable("teamid") Long teamId);
}
