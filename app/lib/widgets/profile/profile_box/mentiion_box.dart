import 'package:app/screens/Hint.dart';
import 'package:flutter/material.dart';

class MentionBox extends StatelessWidget {
  const MentionBox({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Hint(),
            ),
          );
        },
        child: Container(
          width: screenWidth * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xffa3b3f9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth * 0.65,
                    height: screenHeight * 0.025,
                  ),
                  HintCounter(),
                ],
              ),
              Text(
                "토픽제목",
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row HintCounter() {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
