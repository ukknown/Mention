import 'package:app/Screens/group_member.dart';
import '../api/topic_api.dart';
import '../api/topic_model.dart';
import 'package:app/api/group_api.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/api/group_model.dart';
import 'package:app/widgets/bottom_nav.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({
    Key? key,
    required this.propsId,
  }) : super(key: key);

  final int propsId;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GroupApi groupApi = GroupApi();
  late Future<GroupDetailModel> futureGroupData;

  @override
  void initState() {
    super.initState();
    futureGroupData = groupApi.fetchGroupData(widget.propsId);
  }

  void refreshGroupData() {
    setState(() {
      futureGroupData = groupApi.fetchGroupData(widget.propsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<GroupDetailModel>(
      future: futureGroupData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          GroupDetailModel groupDetail = snapshot.data!;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: bgimg(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 00.0),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Flexible(
                      flex: 2,
                      child: _buildGroupHeader(
                          context, groupDetail, screenWidth, screenHeight),
                    ),
                    Flexible(
                      flex: 4,
                      child: _buildGroupDetailCarousel(
                          context, groupDetail, screenWidth, screenHeight),
                    ),
                    const SizedBox(height: 20), // 네모 박스와 로우 사이 여백
                    const SizedBox(height: 20), // 하단 여백
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const BottomNav(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: const Text('Error occurred'),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildGroupHeader(BuildContext context, GroupDetailModel groupDetail,
      double screenWidth, double screenHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.05,
        ),
        ClipOval(
          child: Image.network(
            groupDetail.image,
            height: screenHeight * 0.11,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.05,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.1,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.6,
                      child: Text(
                        groupDetail.name,
                        style: TextStyle(fontSize: 25),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupMember(
                            memberList: groupDetail.memberList,
                            code: groupDetail.code,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.person),
                  ),
                  Text("${groupDetail.capacity}"),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(Icons.notifications_off_rounded),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      // navigator
                    },
                    child: const Icon(Icons.output_outlined),
                  )
                ],
              )
            ],
          ),
        ),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
        SizedBox(
          width: screenWidth * 0.05,
        ),
      ],
    );
  }

  Widget _buildGroupDetailCarousel(BuildContext context,
      GroupDetailModel groupDetail, double screenWidth, double screenHeight) {
    List<Widget> items =
        groupDetail.voteList.asMap().entries.map<Widget>((entry) {
      int index = entry.key;
      VoteModel vote = entry.value;
      return GroupDetail(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        topicTitle: vote.topicTitle,
        emoji: vote.emoji,
        memberList: groupDetail.memberList,
        dueDate: vote.dueDate,
        capacity: groupDetail.capacity,
        index: index,
        participant: vote.participant,
        voteId: vote.voteId,
      );
    }).toList();
    items.add(Groupbox(
      propsId: widget.propsId,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      refreshGroupData: refreshGroupData,
    ));

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        autoPlayCurve: Curves.fastOutSlowIn,
        height: screenHeight * 0.5,
        enlargeCenterPage: true,
      ),
    );
  }
}

class Groupbox extends StatelessWidget {
  const Groupbox(
      {super.key,
      required this.propsId,
      required this.screenWidth,
      required this.screenHeight,
      required this.refreshGroupData});

  final int propsId;
  final double screenWidth;
  final double screenHeight;
  final Function refreshGroupData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          onTap: () => _showNewTopicModal(
            context,
            propsId,
            screenWidth,
            screenHeight,
            refreshGroupData,
          ),
          child: Icon(
            Icons.add_circle_outline_rounded,
            size: screenWidth * 0.2,
          ),
        ),
      ),
    );
  }
}

// 그룹 디테일 페이지

// 토픽 만들기
void _showNewTopicModal(
  BuildContext context,
  int propsId,
  double screenWidth,
  double screenHeight,
  Function refreshGroupData,
) {
  List<SearchTopic> topicList = []; // 상태 변수 추가
  late int pickedTopic; // 선택된 토픽의 id를 저장할 변수

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('새로운 토픽을 골라주세요'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '\'춤\'이라고 검색해보세요',
                      prefixIcon: Icon(
                        Icons.search,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    onSubmitted: (value) async {
                      // 사용자가 입력한 텍스트를 검색 API에 전달하고 결과를 topicList에 저장
                      final results = await TopicApi.topicSearch(value);
                      setState(() {
                        topicList = results;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Column(
                      children: [
                        Text(
                          '검색결과',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: ListView.separated(
                            itemCount: topicList.length,
                            itemBuilder: (context, index) {
                              final topic = topicList[index];
                              return ListTile(
                                title: Text(
                                  '${String.fromCharCode(topic.emoji)} ${topic.title}',
                                ),
                                onTap: () {
                                  setState(() {
                                    pickedTopic = topic.id;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  final topicRandom = await TopicApi.getRandomTopic(propsId);
                  final topic = topicRandom.toSearchTopic(); // 변환
                  setState(() {
                    topicList.add(topic); // 상태 업데이트
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ),
                child: const Text('랜덤'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('Next button clicked');
                  print(pickedTopic);

                  // Call createTopic API
                  await TopicApi.createTopic(propsId, pickedTopic);

                  // Update futureGroupData
                  refreshGroupData();

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: const Text('생성'),
              ),
            ],
          );
        },
      );
    },
    barrierDismissible: true,
  );
}
