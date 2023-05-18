import 'package:app/Screens/vote_after.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../api/group_model.dart';

class VoteMember extends StatefulWidget {
  final List<MemberModel> memberList;
  final String topicTitle;
  final int voteId;
  final int emoji;

  const VoteMember({
    required this.memberList,
    required this.topicTitle,
    required this.emoji,
    required this.voteId,
    Key? key,
  }) : super(key: key);

  @override
  State<VoteMember> createState() => _VoteMemberState();
}

class _VoteMemberState extends State<VoteMember> {
  // 여기서 멤버리스트에 접근가능
  TextEditingController inputController = TextEditingController();
  String inputText = "";

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
                    child: Row(
                      children: [
                        Text(
                          widget.topicTitle,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
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
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.memberList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final member = widget.memberList[index];
                              return Member(
                                nickname: member.nickname,
                                avatarUrl: member.profileImage,
                                id: member.memberId,
                                inputText: inputText,
                                voteId: widget.voteId,
                              );
                            }),
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // children: widget.memberList
                        //     .map((member) => Member(
                        //           nickname: member.nickname,
                        //           avatarUrl: member.profileImage,
                        //           id: member.memberId,
                        //           inputText: inputText,
                        //           voteId: widget.voteId,
                        //         ))
                        //     .toList(),
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
  final int id;
  final String inputText;
  final int voteId;

  const Member({
    required this.nickname,
    required this.avatarUrl,
    required this.id,
    required this.inputText,
    required this.voteId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMentionModal(
          context, nickname, avatarUrl, id, inputText, voteId),
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

void _showMentionModal(BuildContext context, String nickname, String avatarUrl,
    int id, String inputText, int voteId) {
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
                // print(widget.memberList);
                Navigator.of(context).pop();
                _showHintModal(
                    context, nickname, avatarUrl, id, inputText, voteId);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => VotePick(
                //         nickname: nickname, avatarUrl: avatarUrl, id: id),
                //   ),
                // );
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

// 힌트 모달
void _showHintModal(BuildContext context, String nickname, String avatarUrl,
    int id, String inputText, int voteId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('힌트를 작성해 주세요!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: TextField(
                onChanged: (text) {
                  inputText = text;
                  print("출력 $inputText");
                },
                decoration: InputDecoration(
                    isDense: true,
                    fillColor: Color(0xffD9D9D9),
                    filled: true,
                    hintText: 'ex) 나는 키가 커요',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 5)),
                    prefixIcon: const Icon(
                      Icons.edit,
                      size: 16,
                    )),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      // print(widget.memberList);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VotePick(
                            nickname: nickname,
                            avatarUrl: avatarUrl,
                            id: id,
                            hint: inputText,
                            voteId: voteId,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightGreen,
                    ),
                    child: const Text('Yes'),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('No'),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      );
    },
    barrierDismissible: true,
  );
}
