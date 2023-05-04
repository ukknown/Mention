import 'package:app/Screens/group_member.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/Screens/vote_before.dart';
import 'package:app/widgets/bottom_nav.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

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
                            Icon(Icons.border_color_outlined)
                          ],
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
                      items: const [GroupDetail(), GroupDetail(), Groupbox()],
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

class GroupDetail extends StatelessWidget {
  const GroupDetail({
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (const VoteMember())));
        },
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/meet.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Expanded(
                flex: 1,
                child: Text(
                  '밥 먹어보고 싶은 사람',
                  style: TextStyle(fontSize: 20),
                )),
            const Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_rounded),
                  Text(
                    '15/24',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/clock.png',
                  ),
                  const Text(
                    '08:36',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showNewTopicModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('새로운 토픽을 골라주세요'),
            // 여기서 부터 수정
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 변경된 부분
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '\'춤\'이라고 검색해보세요',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    // 추가된 부분
                    child: Container(
                      height: 200, // 주석 처리된 부분
                      width: double.infinity, // 박스 너비 설정
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: 1, // 항목 개수를 1로 설정
                        itemBuilder: (BuildContext context, int index) {
                          return const ListTile(
                            title: Text('검색결과창'), // 검색 결과가 없음을 나타내는 텍스트
                          );
                        },
                      ),
                    ),
                  ),
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
