import 'package:app/api/notice_model.dart';
import 'package:app/widgets/profile/profile_box/notice_mention.dart';
import 'package:app/widgets/profile/profile_box/notice_notice.dart';
import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.name,
    required this.notice,
  });

  final double screenWidth;
  final double screenHeight;
  final String name;
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    if (notice.type == "mention") {
      return NoticeMention(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        name: name,
        isRead: notice.isRead,
        created: notice.data.createdDate,
        id: notice.data.id,
        sender: notice.data.sender,
      );
    } else if (notice.type == "notice") {
      return NoticeNotice(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        name: name,
        isRead: notice.isRead,
        created: notice.data.createdDate,
        id: notice.data.id,
      );
    } else {
      return Container();
    }
  }
}
