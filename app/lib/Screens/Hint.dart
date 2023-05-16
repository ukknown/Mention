// ignore: file_names
// ignore_for_file: unused_import

import 'dart:ui';

import 'package:app/widgets/bottom_nav.dart';
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

  int bang = 100;
  String firstHint = "상대방이 제공하는 힌트";
  String secondHint = "상대방의 초성 힌트";

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
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/coin.png",
                              width: MediaQuery.of(context).size.width * 0.13,
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                            Text(
                              "$bang",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                                    '1단계',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.508,
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
                                            title: const Text("1단계"),
                                            content: const Text(
                                                "뱅을 사용해 1단계 힌트를 열람할까요?"),
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
                                    },
                                    icon: firstsigmaX == 6.0
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
                              firstsigmaX == 6.0
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(28, 7, 28, 7),
                                          child: Text(
                                            "${firstHint}",
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
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            137, 169, 168, 168),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(28, 7, 28, 7),
                                        child: Text(
                                          "${firstHint}",
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
                                    width: MediaQuery.of(context).size.width *
                                        0.508,
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
                                                "뱅을 사용해 2단계 힌트를 열람할까요?"),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(28, 7, 28, 7),
                                          child: Text(
                                            "${secondHint}",
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
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            137, 169, 168, 168),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(28, 7, 28, 7),
                                        child: Text(
                                          "${secondHint}",
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
                                    '3단계',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.508,
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
                                            title: const Text("3단계"),
                                            content: const Text(
                                                "뱅을 사용해 마지막 힌트를 열람할까요?"),
                                            insetPadding:
                                                const EdgeInsets.fromLTRB(
                                                    0, 80, 0, 80),
                                            actions: [
                                              TextButton(
                                                child: const Text('결제'),
                                                onPressed: () {
                                                  setState(() {
                                                    thirdsigmaX = 0.0;
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: thirdsigmaX == 6.0
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
                              thirdsigmaX == 6.0
                                  ? ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                        sigmaX: 4.0,
                                        sigmaY: 4.0,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              136, 228, 225, 225),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Image.asset(
                                                "assets/images/sample2.png")),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.373,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.187,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            137, 169, 168, 168),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/sample2.png"),
                                        ],
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: thirdsigmaX == 6.0
                                    ? ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: 4.0,
                                          sigmaY: 4.0,
                                        ),
                                        child: Text("여도현"),
                                      )
                                    : null,
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
                height: MediaQuery.of(context).size.height * 0.06,
              )
              // Flexible(
              //   flex: 1,
              //   child: Container(),
              // )
            ],
          ),
          bottomNavigationBar: BottomNav()),
    );
  }
}
