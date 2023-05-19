import 'package:flutter/material.dart';
import 'dart:ui';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth, screenHeight;

  void _showSettingModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide.none,
                ),
                elevation: 5,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/setting.png',
                      height: screenWidth * 0.1,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      "설정",
                      style: TextStyle(
                        fontSize: screenWidth * 0.075,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "문의하기",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "개인정보 처리방침",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "앱 버전",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "회원 탈퇴",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSettingModal(context),
      child: Image.asset(
        'assets/images/setting.png',
        height: screenWidth * 0.075,
      ),
    );
  }
}
