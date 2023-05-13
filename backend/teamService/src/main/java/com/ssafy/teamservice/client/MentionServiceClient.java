package com.ssafy.teamservice.client;

import com.ssafy.teamservice.vo.VoteVO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(name = "mention-service")
public interface MentionServiceClient {
    @GetMapping("/mention-service/teams/{teamid}/votes")
    List<VoteVO> getTop2VoteList(@PathVariable Long teamid);
}
