import 'package:app/screens/profile/group_list.dart';
import 'package:flutter/material.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.groupCount,
  });

  final double screenWidth, screenHeight;
  final int groupCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupList(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            'assets/images/group.png',
            height: screenWidth * 0.125,
            width: screenWidth * 0.125,
          ),
          Text(
            '$groupCount',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
