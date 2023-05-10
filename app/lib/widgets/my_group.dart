import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: Container(
        height: screenHeight * 0.15,
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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ssafy.png',
                    height: screenWidth * 0.25,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GroupName",
                    style: TextStyle(
                      color: const Color(0xff2E2E2E),
                      fontSize: screenWidth * 0.075,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: const Color(0xff2E2E2E),
                        size: screenWidth * 0.08,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Text(
                        "24",
                        style: TextStyle(
                          color: const Color(0xff2E2E2E),
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
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
