import 'package:app/Screens/group_member.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:app/widgets/bottom_nav.dart';

class GroupScreen extends StatefulWidget {
  // const GroupScreen(int propsId, {Key? key})
  //     : super(key: key);

  final int propsId;
  const GroupScreen(this.propsId);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  // 질문생성 모달
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0), // 상단 여백
              Flexible(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      foregroundImage: AssetImage('assets/images/ssafy.png'),
                      radius: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '싸피 8기 광주',
                              style: TextStyle(fontSize: 25),
                            ),
                            // 이름 수정
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GroupMember()));
                                },
                                child: const Icon(Icons.person)),
                            // 인원 숫자
                            const Text('24'),
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
                  child: CarouselSlider(
                      items: const [GroupDetail(), Groupbox()],
                      options: CarouselOptions(
                        autoPlayCurve: Curves.fastOutSlowIn,
                        height: 420,
                        enlargeCenterPage: true,
                      ))),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '1 fo 12',
                style: TextStyle(fontSize: 20),
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
