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
    public static String generate() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 3; i++) {
            char c = (char) (random.nextInt(('히' - '가' + 10) / 10) + '가');
            sb.append(c);
        }
        return sb.toString();
    }
}
