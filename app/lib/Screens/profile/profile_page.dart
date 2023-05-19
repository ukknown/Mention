import 'package:app/api/profile_api.dart';
import 'package:app/api/profile_model.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/profile/profile_box/pedometer.dart';
import 'package:app/widgets/profile/profile_box/profile_card.dart';
import 'package:app/widgets/profile/profile_box/rank_slot.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureProfileData;

  @override
  void initState() {
    super.initState();
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
        height: screenHeight,
        decoration: bgimg(),
        child: FutureBuilder(
          future: futureProfileData,
          builder: (
            BuildContext context,
            AsyncSnapshot<Profile> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/warning_h.png',
                      width: screenWidth * 0.50,
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Text(
                      "프로필을 불러오는데 실패했어요!\n잠시 후에 다시 시도해주세요!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            } else {
              final profile = snapshot.data!;

              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    ProfileCard(
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
              );
            }
          },
        ),
      ),
    );
  }
}
