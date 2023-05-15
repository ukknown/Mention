package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.jpa.Gender;
import com.ssafy.notificationservice.jpa.NotificationEntity;
import com.ssafy.notificationservice.jpa.NotificationRepository;
import com.ssafy.notificationservice.jpa.Type;
import com.ssafy.notificationservice.vo.NotificationVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService{
    private final NotificationRepository notificationRepository;
    @Override
    @Transactional
    public void createTopicOpenNotification(Long memberId) {
        NotificationEntity notification = NotificationEntity.builder()
                .memberId(memberId)
                .type(Type.TOPIC_OPEN)
                .gender(Gender.UNSUPPORTED)
                .title("토픽 응모가 시작되었습니다~☘️")
                .build();

        notificationRepository.save(notification);
    }

    @Override
    public void createTopicWinnerNotification(NotificationVO notificationVO) {

    }

    @Override
    public void createMentionNotification(NotificationVO notificationVO) {

    }

    @Override
    public void createTeamVoteNotification(NotificationVO notificationVO) {

    }
}
