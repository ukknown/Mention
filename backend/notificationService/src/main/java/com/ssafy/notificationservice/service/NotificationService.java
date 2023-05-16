package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.NotificationVO;

import java.util.List;

public interface NotificationService {
    void createTopicOpenNotification(Long memberId);
    List<NotificationVO> getNotificationList(Long memberId);
    void createTopicWinnerNotification(NotificationVO notificationVO);
    void createMentionNotification(NotificationVO notificationVO);
    void createTeamVoteNotification(NotificationVO notificationVO);
}
