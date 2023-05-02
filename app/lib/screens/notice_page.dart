import 'package:app/widgets/notice_box.dart';
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
                  const Text("icon"),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  const Text("내 그룹"),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
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
