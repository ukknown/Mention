import 'package:app/screens/group_screen.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.groupId,
    required this.groupImage,
    required this.groupName,
    required this.groupMember,
  });

  final double screenHeight, screenWidth;
  final int groupId;
  final String groupImage;
  final String groupName;
  final int groupMember;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GroupScreen(),
              fullscreenDialog: true,
            ),
          );
        },
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.035,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/$groupImage',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupName,
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
                            groupMember.toString(),
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
        ),
      ),
    );
  }
}
