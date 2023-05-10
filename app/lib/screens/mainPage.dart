<<<<<<< HEAD
// ignore: file_names

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/screens/home_screen.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
=======
>>>>>>> cf928d5f576624a8cd9c595709d18504b30b63be
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app/screens/Hint.dart';
<<<<<<< HEAD
import 'package:app/screens/profile_screen.dart';
=======
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/group_screen.dart';
>>>>>>> cf928d5f576624a8cd9c595709d18504b30b63be

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
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(imgList[index]

                      // fit: BoxFit.fill,
                      );
                },
                onTap: (index) {
                  // debugPrint(imgList[index]);
                  imgList[index] == "assets/images/cashwalk.png"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        )
                      : Null;
                },
                // autoplay: true,
                itemCount: imgList.length,
                pagination: const SwiperPagination(
                  margin: EdgeInsets.all(20),
                ),
                // control: const SwiperControl(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 5,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
<<<<<<< HEAD
                  return Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA3B3F9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 0,
                          blurRadius: 5.0,
                          offset: const Offset(4, 7),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.asset("assets/images/coin.png"),
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "싸피 8기 광주",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "👤 20",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.71,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5C6EAE),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text("test"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [],
                          ),
                        ],
                      ),
=======
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GroupScreen()));
                    },
                    child: Image.asset(
                      "assets/images/mainCard.png",
                      // fit: BoxFit.fill,
>>>>>>> cf928d5f576624a8cd9c595709d18504b30b63be
                    ),
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
        bottomNavigationBar: CircleNavBar(
          activeIndex: 1,
          activeIcons: [
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Hint(),
                    ),
                  );
                  // print("프로필이동");
                },
                color: Colors.deepPurple),
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                color: Colors.black),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  // print("favorite");
                },
                color: Colors.deepPurple),
          ],
          inactiveIcons: [
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Hint(),
                    ),
                  );
                  // print("프로필이동");
                },
                color: Colors.black),
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                color: Colors.black),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Hint(),
                    ),
                  );
                },
                color: Colors.black),
          ],
          color: Colors.white,
          circleColor: Colors.white,
          height: 60,

          circleWidth: 60,
          // tabCurve: ,
          // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            // bottomRight: Radius.circular(24),
            // bottomLeft: Radius.circular(24),
          ),
          shadowColor: const Color(0xff6177E5),
          circleShadowColor: const Color(0xff6177E5),
          elevation: 10,
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.white],
          ),
          circleGradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff6177E5), Color(0xff6177E5)],
          ),
        ),
      ),
    );
  }
}
