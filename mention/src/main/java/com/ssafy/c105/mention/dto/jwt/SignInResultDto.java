package com.ssafy.c105.mention.dto.jwt;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class SignInResultDto extends SignUpResultDto{

    private String token;
    private String username;
    private String email;
}
