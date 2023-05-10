import 'package:app/Screens/notice_page.dart';
import 'package:app/Screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:app/screens/home_screen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIndex: 1,
      activeIcons: [
        IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
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
                  builder: (context) => const ProfilePage(),
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
                  builder: (context) => const NoticePage(),
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
    );
  }
}
