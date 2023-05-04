import 'package:app/widgets/profile/profile_box/mentiion_box.dart';
import 'package:flutter/material.dart';

class ReceivedMentions extends StatelessWidget {
  final double screenHeight, screenWidth;

  const ReceivedMentions({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/group-chat.png',
                  width: screenWidth * 0.2, // 원하는 너비 설정
                  // height: , // 원하는 높이 설정
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Text(
                  "받은 멘션",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          for (var i in [1, 2, 3])
            MentionBox(screenWidth: screenWidth, screenHeight: screenHeight),
        ],
      ),
    );
  }
}
