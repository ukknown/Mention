import 'package:app/Screens/group_member.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:app/api/group_model.dart';
import 'dart:convert' show jsonDecode, utf8;

import 'package:app/widgets/bottom_nav.dart';

// import '../api/group_api.dart';

class GroupScreen extends StatefulWidget {
  // const GroupScreen(int propsId, {Key? key})
  //     : super(key: key);

  final int propsId;
  const GroupScreen(this.propsId);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  Future<GroupDetailModel>? futureGroupData;
  @override
  void initState() {
    super.initState();
    futureGroupData = fetchGroupData();
    print(jsonData);
  }

  Map<String, dynamic> jsonData = {};
  final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  final String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q';

  Future<GroupDetailModel> fetchGroupData() async {
    final response = await http.get(
      Uri.parse(
          'http://k8c105.p.ssafy.io:8000/team-service/teams/${widget.propsId}'), // Replace 'YOUR_ENDPOINT' with the correct endpoint.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      setState(() {
        jsonData = jsonDecode(body);
      });
      // print(jsonData["image"]);
      return GroupDetailModel.fromJson(jsonDecode(body));
    } else {
      throw Exception('Failed to load group data');
    }
  }

  // 질문생성 모달
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 00.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0), // 상단 여백
              Flexible(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.network("${jsonData["image"]}"),
                      radius: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FutureBuilder<GroupDetailModel>(
                              future: futureGroupData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  GroupDetailModel groupDetail = snapshot.data!;
                                  String groupName = groupDetail.name;

                                  return Text(
                                    groupName,
                                    style: TextStyle(fontSize: 25),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error occurred');
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            // 이름 수정
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            FutureBuilder<GroupDetailModel>(
                                future: futureGroupData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    GroupDetailModel groupDetail =
                                        snapshot.data!;
                                    List<MemberModel> memberList =
                                        groupDetail.memberList;

                                    return GestureDetector(
                                      onTap: () {
                                        // print("fdsafs");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupMember(
                                                        memberList:
                                                            memberList)));
                                      },
                                      child: const Icon(Icons.person),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('Error occurre`d');
                                  }
                                  return const CircularProgressIndicator();
                                }),
                            // 인원 숫자
                            Text("${jsonData["capacity"]}"),
                            const SizedBox(
                              width: 40,
                            ),
                            const Icon(Icons.notifications_off_rounded),
                            const SizedBox(
                              width: 40,
                            ),
                            const Icon(Icons.output_outlined)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: FutureBuilder<GroupDetailModel>(
                  future: futureGroupData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GroupDetailModel groupDetail = snapshot.data!;
                      String groupName = groupDetail.name;
                      print(groupName);
                      String groupImage = groupDetail.image;
                      int capacity = groupDetail.capacity;
                      print(groupImage);
                      List<VoteModel> voteList = groupDetail.voteList;
                      List<MemberModel> memberList = groupDetail.memberList;

                      List<Widget> items =
                          voteList.asMap().entries.map<Widget>((entry) {
                        int index = entry.key;
                        VoteModel vote = entry.value;
                        return GroupDetail(
                          topicTitle: vote.topicTitle,
                          memberList: memberList,
                          dueDate: vote.dueDate,
                          capacity: capacity,
                          index: index,
                          participant: vote.participant,
                          voteId: vote.voteId,
                        );
                      }).toList();
                      items.add(const Groupbox());

                      return CarouselSlider(
                          items: items,
                          options: CarouselOptions(
                            autoPlayCurve: Curves.fastOutSlowIn,
                            height: 420,
                            enlargeCenterPage: true,
                          ));
                    } else if (snapshot.hasError) {
                      return const Text('Error occurred');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),

              const SizedBox(height: 20.0), // 네모 박스와 로우 사이 여백

              const SizedBox(height: 20.0), // 하단 여백
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

// 박스 형태
class Groupbox extends StatelessWidget {
  const Groupbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: GestureDetector(
          onTap: () => _showNewTopicModal(context),
          child: const Icon(
            Icons.add_circle_outline_rounded,
            size: 80,
          ),
        ),
      ),
    );
  }
}

// 그룹 디테일 페이지

// 토픽 만들기
void _showNewTopicModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('새로운 토픽을 골라주세요'),
            // 여기서 부터 수정
            content: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 변경된 부분
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '\'춤\'이라고 검색해보세요',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: Text('검색결과',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight
                                .bold)), // 검색 결과가 있는 경우에만 '검색결과' 텍스트를 표시
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  print('Random button clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // 버튼 배경색 설정
                ),
                child: const Text('랜덤'),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Next button clicked');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen, // 버튼 배경색 설정
                ),
                child: const Text('다음'),
              ),
            ],
          );
        },
      );
    },
    barrierDismissible: true,
  );
}
