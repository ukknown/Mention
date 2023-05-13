// ignore: file_names
// ignore_for_file: unused_import

import 'dart:ui';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home_screen.dart';

class Hint extends StatefulWidget {
  const Hint({super.key});

  @override
  State<Hint> createState() => _HintState();
}

class _HintState extends State<Hint> {
  var firstsigmaX = 6.0;
  var firstsigmaY = 6.0;
  var secondsigmaX = 6.0;
  var secondsigmaY = 6.0;
  var thirdsigmaX = 6.0;
  var thirdsigmaY = 6.0;

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
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '1단계',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.54,
                                ),
                                Image.asset(
                                  "assets/images/openlock.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.013,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * 0.35,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(137, 169, 168, 168),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(28, 7, 28, 7),
                                child: Text(
                                  "상대방이 제공하는 힌트",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(221, 92, 91, 91)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7.5,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '2단계',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.508,
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(32.0),
                                            ),
                                          ),
                                          title: const Text("2단계"),
                                          content: const Text(
                                              "3뱅을 사용해 2단계 힌트를 열람할까요?"),
                                          insetPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 80, 0, 80),
                                          actions: [
                                            TextButton(
                                              child: const Text('결제'),
                                              onPressed: () {},
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    // if (secondsigmaX == 0.0) {
                                    //   setState(
                                    //     () {
                                    //       secondsigmaY = 6.0;
                                    //       secondsigmaX = 6.0;
                                    //     },
                                    //   );
                                    // } else {
                                    //   setState(
                                    //     () {
                                    //       secondsigmaY = 0.0;
                                    //       secondsigmaX = 0.0;
                                    //     },
                                    //   );
                                    // }
                                  },
                                  icon: secondsigmaX == 6.0
                                      ? Image.asset(
                                          "assets/images/closelock.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        )
                                      : Image.asset(
                                          "assets/images/openlock.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                ),
                              ],
                            ),
                            secondsigmaX == 6.0
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 6.0,
                                      sigmaY: 6.0,
                                    ),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            137, 169, 168, 168),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(28, 7, 28, 7),
                                        child: Text(
                                          "상대방의 초성 힌트",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  221, 92, 91, 91)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.35,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          137, 169, 168, 168),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(28, 7, 28, 7),
                                      child: Text(
                                        "상대방의 초성 힌트",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                221, 92, 91, 91)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Flexible(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '3단계',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text("이름과 사진"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
