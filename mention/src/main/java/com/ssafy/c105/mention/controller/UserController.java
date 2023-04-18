package com.ssafy.c105.mention.controller;

import com.ssafy.c105.mention.dto.jwt.SignInResultDto;
import com.ssafy.c105.mention.dto.request.user.UserLoginDto;
import com.ssafy.c105.mention.dto.request.user.UserSignupRequestDto;
import com.ssafy.c105.mention.dto.response.api.ApiResponseDto;
import com.ssafy.c105.mention.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/signin")
    public SignInResultDto Signin(@RequestBody UserLoginDto userLoginDto){

        SignInResultDto signInResultDto = userService.Signin(userLoginDto.getUsername(), userLoginDto.getEmail());

        return signInResultDto;
    }

    @PostMapping("/signup")
    public ResponseEntity<ApiResponseDto> signUp(@RequestBody UserSignupRequestDto userRequestDto){
        //LOGGER.info("[signUp] 회원가입을 수행합니다. user_id : {}, password : ****, name : {}", userRequestDto.getUsername(), userRequestDto.getPassword(), userRequestDto.getName());
        userService.signUp(userRequestDto.getUsername(), userRequestDto.getEmail());
        return new ResponseEntity(new ApiResponseDto(true, "User registered successfully@", null), HttpStatus.CREATED);

    }









}
