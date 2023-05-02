import 'package:app/widgets/rank_slot.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
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
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-5, -5),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                    inset: true,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("ImageSpace"),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.05,
                                ),
                                const Text("setting"),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("share"),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("NameSpace"),
                                SizedBox(
                                  width: screenWidth * 0.25,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text("groups"),
                            Text("number"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("metions"),
                            Text("number"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("bangs"),
                            Text("number"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("icon"),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      const Text("다음 Bang까지 00걸음"),
                    ],
                  ),
                  const Text("만보기")
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.075,
            ),
            Column(
              children: [
                const Text("나의 멘션 랭킹"),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                for (var rank in [1, 2, 3])
                  RankSlot(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    rank: rank,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

