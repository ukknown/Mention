import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupVote extends StatelessWidget {
  const GroupVote({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.noticeId,
    required this.routingId,
    required this.regDate,
    required this.noticeTitle,
    required this.targetTitle,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final int noticeId;
  final int routingId;
  final DateTime regDate;
  final String noticeTitle;
  final String targetTitle;

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inMinutes < 2) {
      return '방금 전';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}일 전';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()}주 전';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()}달 전';
    } else {
      return '${(diff.inDays / 365).round()}년 전';
    }
  }

  Future<bool> isRead(int noticeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> readNotices = prefs.getStringList('isRead') ?? [];
    return readNotices.contains(noticeId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final bool isRead = true;

    Color boxColor = const Color(0xFFFFFFFF);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: isRead ? boxColor.withOpacity(0.3) : boxColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isRead
                  ? null
                  : [
                      BoxShadow(
                        offset: const Offset(-5, -5),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                        inset: true,
                      ),
                    ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noticeTitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(timeAgo(regDate)),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                    ),
                    child: Container(
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("icon"),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(targetTitle),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isRead && DateTime.now().difference(regDate).inMinutes <= 10)
            Positioned(
              top: -screenWidth * 0.02,
              right: -screenWidth * 0.02,
              child: Container(
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 5),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
