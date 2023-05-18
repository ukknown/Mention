package com.ssafy.teamservice.utils;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class RandomImageGenerator {
    private static final Random random = new Random();

    public String generate() {

        String[] images ={
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/cloud.png",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/flower.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_10.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_2.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_3.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_5.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_6.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_7.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_8.jpeg",
                "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/random_9.jpeg"
        };

        Random random = new Random();

        // 4자리 숫자 랜덤 코드 생성
        int randomNumber = random.nextInt(images.length);

        return images[randomNumber];
    }
}
