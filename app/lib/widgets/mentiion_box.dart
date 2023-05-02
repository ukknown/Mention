import 'package:flutter/material.dart';

class MentionBox extends StatelessWidget {
  const MentionBox({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          color: const Color(0xffa3b3f9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    width: screenWidth * 0.58, height: screenHeight * 0.03),
                const Text("힌트사용내역"),
              ],
            ),
            const Text("토픽제목"),
            SizedBox(
              height: screenHeight * 0.002,
            )
          ],
        ),
      ),
    );
  }
}
