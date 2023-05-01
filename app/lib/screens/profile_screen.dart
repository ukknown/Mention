import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: const Color(0xffA3B3F9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(-20, -20),
                      blurRadius: 60,
                      color: Colors.black,
                      inset: true,
                    ),
                    BoxShadow(
                      offset: Offset(20, 20),
                      blurRadius: 60,
                      color: Color(0xFFA3B3F9),
                      inset: true,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
