package com.ssafy.notificationservice.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Configuration
public class FCMConfig {
    @Bean
    FirebaseMessaging firebaseMessaging() throws IOException {
        ClassPathResource resource = new ClassPathResource("firebase/mention-d41db-firebase-adminsdk-pvzht-a24518674b.json");
        InputStream refreshToken = resource.getInputStream();
        FirebaseApp firebaseApp = null;
        List<FirebaseApp> firebaseAppList = FirebaseApp.getApps();

        if (firebaseAppList != null && !firebaseAppList.isEmpty()) { // 조건문 변경
            for (FirebaseApp app: firebaseAppList) {
                if (app.getName().equals(FirebaseApp.DEFAULT_APP_NAME)) {
                    firebaseApp = app;
                    break; // 일치하는 앱을 찾으면 루프 종료
                }
            }
        }

        if (firebaseApp == null) { // firebaseApp이 여전히 null인 경우 새로 초기화
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(refreshToken))
                    .build();
            firebaseApp = FirebaseApp.initializeApp(options);
        }
        return FirebaseMessaging.getInstance(firebaseApp);
    }
}

