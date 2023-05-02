import 'package:app/widgets/my_group.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/group.png',
                    width: screenWidth * 0.15, // 원하는 너비 설정
                    // height: , // 원하는 높이 설정
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Text(
                    "내 그룹",
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            for (var i in [1, 2, 3])
              MyGroup(screenHeight: screenHeight, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
