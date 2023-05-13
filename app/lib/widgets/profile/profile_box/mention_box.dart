import 'package:app/api/notice_model.dart';
import 'package:app/screens/Hint.dart';
import 'package:flutter/material.dart';

class MentionBox extends StatelessWidget {
  const MentionBox({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.topicId,
    required this.topicTitle,
    required this.sender,
    required this.hintStep,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final int topicId;
  final String topicTitle;
  // final dynamic sender;
  final Sender sender;
  final int hintStep;

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
            color: genderColor(),
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
                  hintCounter(),
                ],
              ),
              Text(
                topicTitle,
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

  Color genderColor() {
    // if (sender["gender"] == "male") {
    if (sender.gender == "male") {
      return const Color(0xFFA3B3F9);
      // } else if (sender["gender"] == "female") {
    } else if (sender.gender == "female") {
      return const Color(0xFFFEB6C4);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Widget hintCounter() {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: BoxDecoration(
            color: hintStep > 0 ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: BoxDecoration(
            color: hintStep > 1 ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Container(
          width: screenWidth * 0.025,
          height: screenWidth * 0.025,
          decoration: BoxDecoration(
            color: hintStep > 2 ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
