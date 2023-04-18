package com.ssafy.c105.mention.dto.request.user;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserSignupRequestDto {

    private String username; //이름
    private String email; //이메일
}
