import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xffa3b3f9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("누군가 00님에게 @를 보냈어요."),
                  const Text("10분 전"),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                    ),
                    child: Container(
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xffd1d9fc),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(2, 5),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("icon"),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              const Text("토픽제목"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -screenWidth * 0.02,
            right: -screenWidth * 0.02,
            child: Container(
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 5),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
