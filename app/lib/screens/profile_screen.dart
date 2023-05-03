import 'package:app/widgets/profile_card.dart';
import 'package:app/widgets/rank_slot.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            ProfileCard(screenHeight: screenHeight, screenWidth: screenWidth),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("icon"),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      const Text("다음 Bang까지 00걸음"),
                    ],
                  ),
                  const Text("만보기")
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.075,
            ),
            Column(
              children: [
                const Text("나의 멘션 랭킹"),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                for (var rank in [1, 2, 3])
                  RankSlot(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    rank: rank,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
