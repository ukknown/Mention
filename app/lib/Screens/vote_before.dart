import 'package:app/Screens/vote_after.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../api/group_model.dart';

class VoteMember extends StatefulWidget {
  final List<MemberModel> memberList;
  final String topicTitle;
  const VoteMember({required this.memberList,required this.topicTitle, Key? key}) : super(key: key);

  @override
  State<VoteMember> createState() => _VoteMemberState();
}

class _VoteMemberState extends State<VoteMember> {
  // 여기서 멤버리스트에 접근가능

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.topicTitle,
                      style: TextStyle(fontSize: 30),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: widget.memberList
                              .map((member) => Member(
                                  nickname: member.nickname,
                                  avatarUrl: member.profileImage))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class Member extends StatelessWidget {
  final String nickname;
  final String avatarUrl;

  const Member({
    required this.nickname,
    required this.avatarUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMentionModal(context, nickname, avatarUrl),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    nickname,
                    style: TextStyle(fontSize: 25),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

void _showMentionModal(
    BuildContext context, String nickname, String avatarUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$nickname님을 멘션할까요?'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VotePick(nickname: nickname, avatarUrl: avatarUrl)),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightGreen,
              ),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text('No'),
            ),
          ],
        ),
      );
    },
    barrierDismissible: true,
  );
}
