import 'package:app/api/notice_model.dart';
import 'package:app/widgets/profile/profile_box/notice_group_vote.dart';
import 'package:app/widgets/profile/profile_box/notice_mention.dart';
import 'package:app/widgets/profile/profile_box/notice_topic_open.dart';
import 'package:app/widgets/profile/profile_box/notice_topic_winner.dart';
import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.notice,
  });

  final double screenWidth;
  final double screenHeight;
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    if (notice.noticeType  == "MENTION") {
      return NoticeMention(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        noticeId : notice.noticeId,
        routingId : notice.routingId,
        regDate: notice.regDate,
        noticeTitle: notice.noticeTitle,
        targetTitle: notice.targetTitle,
        gender: notice.gender,
      );
    } else if (notice.noticeType  == "GROUP_VOTE") {
      return GroupVote(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        noticeId : notice.noticeId,
        routingId : notice.routingId,
        regDate: notice.regDate,
        noticeTitle: notice.noticeTitle,
        targetTitle: notice.targetTitle,
      );
    } else if (notice.noticeType  == "TOPIC_OPEN") {
      return TopicOpen(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        noticeId : notice.noticeId,
        regDate: notice.regDate,
        noticeTitle: notice.noticeTitle,
      );
    } else if (notice.noticeType  == "TOPIC_WINNER") {
      return TopicWinner(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        noticeId : notice.noticeId,
        regDate: notice.regDate,
        noticeTitle: notice.noticeTitle,
        targetTitle: notice.targetTitle,
      );
    } else {
      return Container();
    }
  }
}
