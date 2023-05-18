package com.ssafy.teamservice.utils;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class RandomCodeGenerator {
    private static final Random random = new Random();

    /**
     * 한 글자에 음절이 3개인 4글자 랜덤코드 생성
     * @return
     */
    public int generate() {
        Random random = new Random();

        // 4자리 숫자 랜덤 코드 생성
        int code = random.nextInt(9000) + 1000;

        return code;
    }
}
