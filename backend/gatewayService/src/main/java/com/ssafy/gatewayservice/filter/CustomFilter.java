package com.ssafy.gatewayservice.filter;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class CustomFilter extends AbstractGatewayFilterFactory<CustomFilter.Config> {
    public CustomFilter(){
        super(Config.class);
    }

    @Override
    public GatewayFilter apply(Config config) {
        // Custom Pre Filter
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest(); //요청 객체 추출
            ServerHttpResponse response = exchange.getResponse(); //응답 객체 추출

            //요청에 대하 전처리 작업, 요청 객체의 ID를 로깅
            log.info("Custom PRE Filter: request id -> {}", request.getId());

            //Gatewayhandler를 실행, 실행팔 파일을 Mono.fromRunnable()을 통해 등록
            // 응답 객체의 HTTP 상태 코드를 로깅
            return chain.filter(exchange).then(Mono.fromRunnable(() -> {
                log.info("Custom PRE Filter: request id -> {}", response.getStatusCode());
            }));
        };
    }

    public static class Config{

    }
}
