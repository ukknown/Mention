import 'package:app/screens/profile/received_mentions.dart';
import 'package:flutter/material.dart';

class MentionButton extends StatelessWidget {
  const MentionButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceivedMentions(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            'assets/images/mention.png',
            height: screenWidth * 0.125,
            width: screenWidth * 0.125,
          ),
          const Text(
            "00",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
