import 'package:app/widgets/profile/profile_box/notice_box.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/bell.png',
                    width: screenWidth * 0.2, // 원하는 너비 설정
                    // height: , // 원하는 높이 설정
                  ),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Text(
                    "알림",
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              for (var i in [1, 2, 3])
                NoticeBox(screenWidth: screenWidth, screenHeight: screenHeight)
            ],
          ),
        ),
      ),
    );
  }
}
