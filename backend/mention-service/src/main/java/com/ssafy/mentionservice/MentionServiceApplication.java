package com.ssafy.mentionservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class MentionServiceApplication {
	public static void main(String[] args) {
		SpringApplication.run(MentionServiceApplication.class, args);
	}

}
