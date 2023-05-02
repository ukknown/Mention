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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            const Text("내 그룹"),
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
