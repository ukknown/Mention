import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadJson() async {
  final String jsonString = await rootBundle.loadString('lib/api/member.json');
  return json.decode(jsonString);
}

class GroupMember extends StatefulWidget {
  const GroupMember({super.key});

  @override
  State<GroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  late List<dynamic> memberData = [];

  @override
  void initState() {
    super.initState();
    loadJson().then((value) {
      setState(() { 
        memberData = value;
      });
    });
  }

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
                          const Text(
                            '멤버',
                            style: TextStyle(fontSize: 30),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showJoinCodeModal(context);
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
                        ...memberData.map((person) => Member(person: person)),
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

class Member extends StatelessWidget {
  final Map<String, dynamic> person;
  const Member({required this.person, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const Expanded(
              flex: 4,
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            Expanded(
                flex: 4,
                child: Text(
                  person["name"],
                  style: const TextStyle(fontSize: 25),
                )),
            // Expanded(flex: 1, child: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}

void _showJoinCodeModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '참여코드',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '61809',
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
