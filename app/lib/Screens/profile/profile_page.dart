import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/profile/profile_box/pedometer.dart';
import 'package:app/widgets/profile/profile_box/profile_card.dart';
import 'package:app/widgets/profile/profile_box/rank_slot.dart';
import 'package:flutter/material.dart';

import 'package:app/api/profile_api.dart';
import 'package:app/api/profile_model.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late Future<Map<String, dynamic>> futureProfileData;
  late Future<Profile> futureProfileData;

  // Future<Map<String, dynamic>> loadProfileData() async {
  //   final jsonString =
  //       await rootBundle.loadString('lib/api/profile_screen.json');
  //   final jsonData = json.decode(jsonString);
  //   return jsonData;
  // }

  @override
  void initState() {
    super.initState();
    // futureProfileData = loadProfileData();
    futureProfileData = ProfileApi.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      bottomNavigationBar: const BottomNav(),
      body: Container(
        decoration: bgimg(),
        child: FutureBuilder(
          future: futureProfileData,
          builder: (
            BuildContext context,
            // AsyncSnapshot<Map<String, dynamic>> snapshot,
            AsyncSnapshot<Profile> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 에러 메시지를 표시합니다.
              print('Error: ${snapshot.error}');
              return const Center(
                child: Text(
                  'An error occurred. Please try again later.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              // final profileData = snapshot.data!;
              final profile = snapshot.data!;

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      ProfileCard(
                        // profileImage: profileData['profile_image'],
                        // name: profileData['name'],
                        // coin: profileData['coin'],
                        // groupCount: profileData['group_count'],
                        // mentionCount: profileData['mention_count'],
                        profileImage: profile.profileImage,
                        name: profile.name,
                        coin: profile.coin,
                        groupCount: profile.groupCount,
                        mentionCount: profile.mentionCount,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
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
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.055),
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
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.055),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            // for (var entry
                            //     in profileData['most_mentioned_topic']
                            //         .asMap()
                            //         .entries)
                            //   RankSlot(
                            //     screenWidth: screenWidth,
                            //     screenHeight: screenHeight,
                            //     topic: entry.value,
                            //     rank: entry.key + 1,
                            //   ),

                            for (var entry
                                in profile.mostMentionedTopic.asMap().entries)
                              RankSlot(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                topic: entry.value.title,
                                mentionedCount: entry.value.mentionedCount,
                                rank: entry.key + 1,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
