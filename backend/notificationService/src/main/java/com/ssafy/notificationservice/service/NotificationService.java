package com.ssafy.notificationservice.service;

import com.ssafy.notificationservice.vo.NotificationVO;

public interface NotificationService {
    void createTopicOpenNotification(Long memberId);
    void createTopicWinnerNotification(NotificationVO notificationVO);
    void createMentionNotification(NotificationVO notificationVO);
    void createTeamVoteNotification(NotificationVO notificationVO);

}
