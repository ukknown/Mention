import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../api/group_model.dart';

class GroupMember extends StatelessWidget {
  final List<MemberModel> memberList;
  final int code;
  const GroupMember({
    Key? key,
    required this.memberList,
    required this.code,
  }) : super(key: key);

  // GroupDetailModel? group;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const GroupScreen()));
                            },
                            child: const Text(
                              '멤버',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showJoinCodeModal(context, code);
                            },
                            child: const Icon(
                              Icons.add_circle_outline_sharp,
                              size: 40,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '이름 검색',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 5)),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 16,
                              )),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // 멤버에 데이터 넣는 곳 (json형태로)
                        ...memberList
                            .map((member) =>
                                MemberWidget(member: member, code: code))
                            .toList(),
                      ],
                    ),
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

class MemberWidget extends StatelessWidget {
  final MemberModel member;
  final int code;

  const MemberWidget({required this.member, required this.code, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(member.profileImage),
              ),
            ),
            Expanded(
                flex: 4,
                child: Text(
                  member.nickname,
                  style: const TextStyle(fontSize: 25),
                )),
            // Expanded(flex: 1, child: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}

void _showJoinCodeModal(BuildContext context, int code) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '참여코드',
          textAlign: TextAlign.center,
        ),
        content: Text(
          '$code',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print('Send join code via KakaoTalk');
              Navigator.of(context).pop();
            },
            // 카카오 아이콘으로 바꾸기
            child: const Center(
                child: Icon(
              Icons.send,
              size: 35,
            )),
          ),
        ],
      );
    },
    barrierDismissible: true,
  );
}
