// ignore: file_names
// ignore_for_file: unused_import, unused_local_variable

import 'dart:ui';
import 'dart:convert';
import 'dart:io';

import 'package:app/Screens/lastHint.dart';
import 'package:http/http.dart' as http;
import 'package:app/widgets/bottom_nav.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home_screen.dart';

class Hint extends StatefulWidget {
  const Hint({required this.mentionId, Key? key});

  final int mentionId;

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

  int bang = 0;
  String hintOne = "";
  String hintTwo = "";
  String hintThree = "";
  dynamic profileImg;
  int? hintStatus;
  int? changeBang;
  int checkpage = 0;

  @override
  void initState() {
    super.initState();
    getHint();
    // print(hintStatus);
    // if (hintStatus == 3) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => lastHint(
    //         nickname: hintThree,
    //         profileImg: profileImg,
    //       ),
    //     ),
    //   );
    // }
  }

  void getHint() async {
    const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
    // final prefs = await SharedPreferences.getInstance();
    // late String accessToken = prefs.getString("token")!;

    final url =
        Uri.parse('${baseUrl}/mention-service/mentions/${widget.mentionId}');
    try {
      final response = await http.get(url, headers: <String, String>{
        // 'Authorization': "Bearer $accessToken",
        'Authorization':
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q",
      });
// eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDA2Njk1NCwiZXhwIjoxNjg2NjU4OTU0fQ.HCwqWAat8tsT3GYsWLXb3YKznWP-Pdk7c-0GMvRn3wgMwNQeZbp6j2KpVBqyulVRiA7aa3fx6bqAyRPHxYhAJw
      if (response.statusCode == 200) {
        final List<int> bytes = response.bodyBytes;
        final String responseBody = utf8.decode(bytes);
        final Map<String, dynamic> profileJson = jsonDecode(responseBody);
        if (profileJson["hintStatus"] == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => lastHint(
                nickname: hintThree,
                profileImg: profileImg,
              ),
            ),
          );
        }
        print("변환 완료 $profileJson");
        print(profileJson["hintTwo"]);
        setState(() {
          bang = profileJson["bang"];
          hintOne = profileJson["hintOne"];
          hintTwo = profileJson["hintTwo"];
          hintThree = profileJson["hintThree"];
          profileImg = profileJson["profileImg"];
          hintStatus = profileJson["hintStatus"];
        });

        // List<dynamic> updatedSwiperList = [];
      } else {
        print('Server responded with status code: ${response.statusCode}');
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateBang() async {
    // void sendMention() async {
    final url = Uri.parse('http://k8c105.p.ssafy.io:8000/member-service/bangs');

    final body = {
      "bang": changeBang,
    };

    final jsonBody = jsonEncode(body);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization':
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q",
        'Content-Type': 'application/json', // JSON 형식으로 보내기 위한 헤더 추가
      },
      body: jsonBody,
    );

    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 요청을 보냈을 경우
      print('요청이 성공적으로 완료되었습니다.');
      print(response.body);
    } else {
      // 요청이 실패했을 경우
      print('요청이 실패하였습니다. 에러 코드: ${response.statusCode}');
    }
  }

  Future<void> updateHintStatus() async {
    const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
    final url =
        Uri.parse('${baseUrl}/mention-service/mentions/${widget.mentionId}');

    final response = await http.put(
      url,
      headers: <String, String>{
        'Authorization':
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q",
      },
    );

    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 요청을 보냈을 경우
      print('요청이 성공적으로 완료되었습니다.');
      print(response.body);
    } else {
      // 요청이 실패했을 경우
      print('요청이 실패하였습니다. 에러 코드: ${response.statusCode}');
    }
  }

//   /mention-service/mentions/{mentionId}
// {
//     "hintStatus": 힌트단계
//     "hintOne": voter가 적은 힌트
//     "hintTwo": voter 초성
//     "hintThree": voter 이름
//     "profileImg": "https://mention-bucket.s3.ap-northeast-2.amazonaws.com/static/team-image/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-03-17_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.14.48-removebg-preview.png",
//     "bang": 본인 bang
// }
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
                                      hintStatus == 0
                                          ? showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(32.0),
                                                    ),
                                                  ),
                                                  title: const Text("1단계"),
                                                  content: const Text(
                                                      "3뱅을 사용해 1단계 힌트를 열람할까요?"),
                                                  insetPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 80, 0, 80),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('결제'),
                                                      onPressed: () {
                                                        setState(() {
                                                          changeBang = -3;
                                                        });
                                                        updateBang();
                                                        updateHintStatus();
                                                        getHint();
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          this.hintStatus = 1;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : null;
                                    },
                                    icon: hintStatus == 0
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
                              hintStatus == 0
                                  ? ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                        sigmaX: 3.5,
                                        sigmaY: 4.0,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              136, 191, 190, 190),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 7, 20, 7),
                                          child: Text(
                                            "${hintOne}",
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
                                          "${hintOne}",
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
                                      hintStatus == 1
                                          ? showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(32.0),
                                                    ),
                                                  ),
                                                  title: const Text("2단계"),
                                                  content: const Text(
                                                      "4뱅을 사용해 2단계 힌트를 열람할까요?"),
                                                  insetPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 80, 0, 80),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('결제'),
                                                      onPressed: () {
                                                        setState(() {
                                                          changeBang = -4;
                                                        });
                                                        updateBang();
                                                        updateHintStatus();
                                                        getHint();
                                                        setState(() {
                                                          this.hintStatus = 2;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : null;
                                    },
                                    icon: hintStatus != 2
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
                              hintStatus != 2
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
                                            "${hintTwo}",
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
                                          "${hintTwo}",
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
                                      hintStatus == 2
                                          ? showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(32.0),
                                                    ),
                                                  ),
                                                  title: const Text("3단계"),
                                                  content: const Text(
                                                      "5뱅을 사용해 상대를 확인할까요?"),
                                                  insetPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 80, 0, 80),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('결제'),
                                                      onPressed: () {
                                                        setState(() {
                                                          setState(() {
                                                            bang = bang - 5;
                                                            changeBang = -5;
                                                          });
                                                          updateHintStatus();
                                                          updateBang();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      lastHint(
                                                                nickname:
                                                                    hintThree,
                                                                profileImg:
                                                                    profileImg,
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : null;
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
                                                "assets/images/girl 2.png")),
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
