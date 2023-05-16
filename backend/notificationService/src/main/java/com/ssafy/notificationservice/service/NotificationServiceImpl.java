package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.client.MentionFeignClient;
import com.ssafy.notificationservice.client.TeamFeignClient;
import com.ssafy.notificationservice.jpa.Gender;
import com.ssafy.notificationservice.jpa.NotificationEntity;
import com.ssafy.notificationservice.jpa.NotificationRepository;
import com.ssafy.notificationservice.jpa.Type;
import com.ssafy.notificationservice.vo.NotificationVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService{
    private final NotificationRepository notificationRepository;
    private final TeamFeignClient teamFeignClient;
    private final MentionFeignClient mentionFeignClient;
    @Override
    @Transactional
    public void createTopicOpenNotification(Long memberId) {
        NotificationEntity notification = NotificationEntity.builder()
                .memberId(memberId)
                .type(Type.TOPIC_OPEN)
                .gender(Gender.UNKNOWN)
                .title("토픽 응모가 시작되었습니다~☘️")
                .build();

        notificationRepository.save(notification);
    }

    @Override
    public List<NotificationVO> getNotificationList(Long memberId) {
        List<NotificationEntity> notificationEntityList = notificationRepository.findByMemberIdOrderByRegDateDesc(memberId);

        return notificationEntityList.stream()
                .map(entity -> new NotificationVO(entity))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void createTopicWinnerNotification(NotificationVO notificationVO) {
        // 응모 당첨된 토픽
        StringBuilder sb = new StringBuilder();
        sb.append("축하합니다🎉 작성해주신 토픽이 응모에 당첨되었습니다!");
        sb.append(" * ");
        sb.append(mentionFeignClient.getTopicTitleByTopicId(notificationVO.getRoutingId()));

        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .gender(Gender.UNKNOWN)
                .type(Type.TOPIC_WINNER)
                .title(sb.toString())
                .build();

        notificationRepository.save(notification);
    }

    @Override
    @Transactional
    public void createMentionNotification(NotificationVO notificationVO) {
        StringBuilder sb = new StringBuilder();
        sb.append("(😋)누군가가 당신을 멘션했어요!!");
        sb.append(" * ");
        sb.append(mentionFeignClient.getTopicTitleByMentionId(notificationVO.getRoutingId()));

        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .type(Type.MENTION)
                .gender(Gender.UNKNOWN)
                .routingId(notificationVO.getRoutingId())
                .gender(notificationVO.getGender())
                .title(sb.toString())
                .build();

        notificationRepository.save(notification);
    }

    @Override
    @Transactional
    public void createTeamVoteNotification(NotificationVO notificationVO) {
        StringBuilder sb = new StringBuilder();
        sb.append("[" + teamFeignClient.getTeamName(notificationVO.getRoutingId()) + "] 에서 새로운 투표가 열렸어요! 참여해보세요~🚀");
        sb.append(" * ");
        sb.append(mentionFeignClient.getTopicTitleByVoteId(notificationVO.getRoutingId()));

        NotificationEntity notification = NotificationEntity.builder()
                .memberId(notificationVO.getMemberId())
                .type(Type.GROUP_VOTE)
                .gender(Gender.UNKNOWN)
                .routingId(notificationVO.getRoutingId())
                .title(sb.toString())
                .build();
        notificationRepository.save(notification);
    }
}
