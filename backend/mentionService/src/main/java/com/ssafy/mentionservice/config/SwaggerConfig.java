package com.ssafy.mentionservice.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.security.SecurityScheme.In;
import io.swagger.v3.oas.models.security.SecurityScheme.Type;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI(){
        Info info = new Info()
                .title("멘션 API Documentation")
                .version("v1.0.0")
                .description("MENTION API에 대한 설명 문서입니다!");

        SecurityScheme securityScheme = new SecurityScheme()
                .type(Type.HTTP)
                .scheme("Bearer")
                .bearerFormat("JWT")
                .in(In.HEADER).name("Authorization");

        return new OpenAPI()
                .components(new Components().addSecuritySchemes("bearerAuth", securityScheme))
                .info(info);
    }
}

