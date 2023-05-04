import 'package:app/widgets/profile/profile_buttons/coin_button.dart';
import 'package:app/widgets/profile/profile_buttons/group_button.dart';
import 'package:app/widgets/profile/profile_buttons/mention_button.dart';
import 'package:app/widgets/profile/profile_buttons/setting_button.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.32,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffA3B3F9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
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
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile-example.png',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SettingButton(screenWidth: screenWidth, screenHeight: screenHeight),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/images/share.png',
                            height: screenWidth * 0.075,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        "김싸피",
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GroupButton(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SizedBox(
                  width: screenWidth * 0.125,
                ),
                MentionButton(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SizedBox(
                  width: screenWidth * 0.125,
                ),
                CoinButton(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


