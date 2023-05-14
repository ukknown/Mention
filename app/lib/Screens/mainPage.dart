// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/dailymissonswiper.dart';
import 'package:app/widgets/maingroupcard.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app/screens/Hint.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> imgList = [
    'assets/images/completetoday.png',
    'assets/images/tomention.png',
    'assets/images/topic.png',
    'assets/images/cashwalk.png'
  ];

  List<Widget> swiperList = [];

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    const String baseUrl = 'http://k8c105.p.ssafy.io:8000';

    final url = Uri.parse('$baseUrl/team-service/teams');
    try {
      final response = await http.get(url, headers: <String, String>{
        'Authorization':
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDA2Njk1NCwiZXhwIjoxNjg2NjU4OTU0fQ.HCwqWAat8tsT3GYsWLXb3YKznWP-Pdk7c-0GMvRn3wgMwNQeZbp6j2KpVBqyulVRiA7aa3fx6bqAyRPHxYhAJw",
      });

      if (response.statusCode == 200) {
        final List<dynamic> profileJson = jsonDecode(response.body);
        for (dynamic group in profileJson) {
          print(group);
        }
        ;
        // print(profileJson);
      } else {
        print('Server responded with status code: ${response.statusCode}');
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/backgroundBall.png',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("다음으로"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Hint(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: dailymissonswiper(imgList: imgList),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Flexible(
              flex: 5,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  // igneore: prefer_const_constructors
                  return swipercontainer(
                    groupimg: "fdasfasfa",
                    groupname: "dfasasf",
                    membernum: 12,
                  );
                  // return Image.asset(
                  //   "assets/images/mainCard.png",
                  //   // fit: BoxFit.fill,
                  // );
                },
                // itemHeight: 500,
                // itemWidth: 500,
                itemCount: 3,
                viewportFraction: 0.8,
                scale: 0.81,
                pagination: const SwiperPagination(
                  margin: EdgeInsets.all(0.0),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        bottomNavigationBar: const BottomNav(),
      ),
    );
  }
}


// 스와이퍼 위젯
// ignore: camel_case_types
