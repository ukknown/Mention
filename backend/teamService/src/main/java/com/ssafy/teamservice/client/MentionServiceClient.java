package com.ssafy.teamservice.client;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "mention-service")
public interface MentionServiceClient {
}
