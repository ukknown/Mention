import 'package:app/Screens/group_member.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/Screens/vote_before.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GroupMember()));
                        },
                        child: const Row(
                          children: [
                            Text(
                              '싸피 8기 광주',
                              style: TextStyle(fontSize: 25),
                            ),
                            Icon(Icons.add)
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.person),
                          Text('24'),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(Icons.notifications_off_rounded),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(Icons.output_outlined)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Flexible(
                flex: 4,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (const VoteMember())))
                  },
                  child: CarouselSlider(
                      items: const [GroupDetail(), GroupDetail(), group_box()],
                      options: CarouselOptions(
                        autoPlayCurve: Curves.fastOutSlowIn,
                        height: 420,
                        enlargeCenterPage: true,
                      )),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '1 fo 12',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20.0), // 네모 박스와 로우 사이 여백
            Flexible(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0), // 하단 여백
          ],
        ),
      ),
    );
  }
}

// 박스 형태
class group_box extends StatelessWidget {
  const group_box({
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
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('새로운 토픽을 골라주세요'),
                    content: const SizedBox(
                      height: 250,
                      child: Column(
                        children: [Text('검색창'), Text('인풋 공간')],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                  // return const GroupDetail();
                });
          },
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
    );
  }
}
