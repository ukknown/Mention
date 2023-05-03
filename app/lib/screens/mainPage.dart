import 'package:app/screens/home_screen.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app/screens/Hint.dart';
import 'package:app/screens/group_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
                  return Image.asset(
                    "assets/images/dailyQuestCheck.png",
                    // fit: BoxFit.fill,
                  );
                },
                itemCount: 3,
                pagination: const SwiperPagination(
                  margin: EdgeInsets.all(30),
                ),
                // control: const SwiperControl(),
              ),
            ),
            Flexible(
              flex: 4,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
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
                    ),
                  );
                },
                // itemHeight: 500,
                // itemWidth: 500,
                itemCount: 10,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: const SwiperPagination(
                  margin: EdgeInsets.all(0),
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
