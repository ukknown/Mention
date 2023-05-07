import 'package:app/screens/profile/pedometer.dart';
import 'package:app/widgets/profile/profile_box/profile_card.dart';
import 'package:app/widgets/profile/profile_box/rank_slot.dart';
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
              height: screenHeight * 0.075,
            ),
            ProfileCard(screenHeight: screenHeight, screenWidth: screenWidth),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/running.png',
                        height: screenWidth * 0.1,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Text(
                        "다음 Bang까지 00걸음!",
                        style: TextStyle(fontSize: screenWidth * 0.055),
                      ),
                    ],
                  ),
                  PedometerText(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/podium.png',
                        height: screenWidth * 0.1,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Text(
                        "나의 멘션 랭킹",
                        style: TextStyle(fontSize: screenWidth * 0.055),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  for (var rank in [1, 2, 3])
                    RankSlot(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      rank: rank,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
