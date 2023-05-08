import 'package:flutter/material.dart';

class RankSlot extends StatelessWidget {
  const RankSlot({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.rank,
  });

  final double screenWidth;
  final double screenHeight;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1,
        bottom: screenHeight * 0.01,
      ),
      child: Container(
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.83),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Rank"),
              Column(
                children: [
                  Row(
                    children: const [
                      Text("imoji"),
                      Text("topicName"),
                    ],
                  ),
                  Row(
                    children: const [
                      Text("bangIcon"),
                      Text("number"),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
