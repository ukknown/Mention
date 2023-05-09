import 'package:app/widgets/profile/profile_box/pedometer.dart';
import 'package:app/widgets/profile/profile_box/profile_card.dart';
import 'package:app/widgets/profile/profile_box/rank_slot.dart';
import 'package:flutter/material.dart';

// 이건 나중에 지워야 할 것
import 'dart:convert';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>> loadProfileData() async {
    final jsonString =
        await rootBundle.loadString('lib/api/profile_screen.json');
    final jsonData = json.decode(jsonString);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: FutureBuilder(
        future: loadProfileData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<String, dynamic>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final profileData = snapshot.data!;
            print(profileData);
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.075,
                  ),
                  ProfileCard(
                    profileImage: profileData['profile_image'],
                    name: profileData['name'],
                    coin: profileData['coin'],
                    groupCount: profileData['group_count'],
                    mentionCount: profileData['mention_count'],
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                        for (var entry in profileData['most_mentioned_topic'].asMap().entries)
                          RankSlot(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            topic: entry.value,
                            rank: entry.key + 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
