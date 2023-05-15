package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.client.TeamFeignClient;
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
    private final TeamFeignClient teamFeignClient;
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
    @Transactional
    public void createTopicWinnerNotification(NotificationVO notificationVO) {
        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .gender(Gender.UNSUPPORTED)
                .type(Type.TOPIC_WINNER)
                .title("축하합니다🎉 작성해주신 토픽이 응모에 당첨되었습니다!")
                .build();
        notificationRepository.save(notification);
    }

    @Override
    @Transactional
    public void createMentionNotification(NotificationVO notificationVO) {
        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .type(Type.MENTION)
                .gender(Gender.UNSUPPORTED)
                .routingId(notificationVO.getRoutingId())
                .gender(notificationVO.getGender())
                .title("누군가가 당신을 멘션했어요 📣")
                .build();
        notificationRepository.save(notification);
    }

    @Override
    @Transactional
    public void createTeamVoteNotification(NotificationVO notificationVO) {
        String message = teamFeignClient.getTeamName(notificationVO.getRoutingId()) + "에서 새로운 투표가 열렸어요! 참여해보세요~🚀";
        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .type(Type.GROUP_VOTE)
                .gender(Gender.UNSUPPORTED)
                .routingId(notificationVO.getRoutingId())
                .gender(Gender.UNSUPPORTED)
                .title(message)
                .build();
        notificationRepository.save(notification);
    }
}
