import 'package:app/widgets/mentiion_box.dart';
import 'package:flutter/material.dart';

class ReceivedMentions extends StatelessWidget {
  // final double screenHeight, screenWidth;

  const ReceivedMentions({
    super.key,
    // required this.screenHeight,
    // required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            const Text("받은 멘션"),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            MentionBox(screenWidth: screenWidth, screenHeight: screenHeight),
            MentionBox(screenWidth: screenWidth, screenHeight: screenHeight),
          ],
        ),
      ),
    );
  }
}

