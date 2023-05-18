// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:app/Screens/group_screen.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/dailymissonswiper.dart';
import 'package:app/widgets/maingroupcard.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app/screens/Hint.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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

  File? userImage;

  final List<dynamic> swiperList = [];
  TextEditingController inputController = TextEditingController();
  String inputText = '';
  File? imageFile;
  late int propsId = -1;
  Swiper? swiper;

  final String baseUrl = 'http://k8c105.p.ssafy.io:8000';
  final String token =
      // 노준호
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuamgzMzIxQG5hdmVyLmNvbSIsImVtYWlsIjoibmpoMzMyMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuFuOykgO2YuCIsImlhdCI6MTY4NDQxOTk3MywiZXhwIjoxNjg3MDExOTczfQ.56J4Bu9u3lB0UWb236RVH7TKWsAaiSOoB887o-hYjDFbtIjcZmavaeg4LLWA_W7H4hScavCDghgMQdCyWS-JNw';
  // 여도현
  // 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q';

  @override
  void initState() {
    super.initState();
    getProfile(); // getProfile 함수를 호출합니다
  }

  // 그룹 생성하기
  void postRequest(String inputText) async {
    var url = Uri.parse('$baseUrl/team-service/teams/');
    Map<String, String> data = {
      'name': inputText,
    };

    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('요청 성공: ${response.body}');
      getProfile();
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

  // 숫자코드로 입장하는 코드
  void sendPostRequest(int code) async {
    var url = Uri.parse('$baseUrl/team-service/teams');

    var response = await http.post(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      print('요청 성공: ${response.body}');
      getProfile();
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

// 그룹정렬하기
  void getProfile() async {
    final url = Uri.parse('$baseUrl/team-service/teams');

    try {
      final response = await http.get(url,
          headers: <String, String>{'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final List<int> bytes = response.bodyBytes;
        final String responseBody = utf8.decode(bytes);
        final List<dynamic> profileJson = jsonDecode(responseBody);

        setState(() {
          swiperList.clear();

          for (dynamic group in profileJson) {
            swiperList.add(swipercontainer(
              groupimg: group["image"],
              groupname: group["name"],
              membernum: group["capacity"],
              id: group["id"],
              vote: group["voteList"],
              screenWidth: MediaQuery.of(context).size.width,
            ));
          }

          swiperList.add(
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 0,
                    blurRadius: 5.0,
                    offset: const Offset(4, 7),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 80,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );

          swiper = Swiper(
            itemBuilder: (BuildContext context, int index) {
              return swiperList[index];
            },
            onTap: (index) {
              index == (swiperList.length - 1)
                  ? _newGroupModal(context)
                  : setState(() {
                      propsId = swiperList[index].id;
                    });
              if (swiperList[index].id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupScreen(propsId: propsId),
                  ),
                );
              }
            },
            itemCount: swiperList.length,
            viewportFraction: 0.8,
            scale: 0.81,
            pagination: const SwiperPagination(
              margin: EdgeInsets.all(0),
            ),
          );
        });
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
    final screenHeight = MediaQuery.of(context).size.height;
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
            SizedBox(height: screenHeight * 0.06),
            // 미션
            Flexible(
              flex: 1,
              child: dailymissonswiper(imgList: imgList),
            ),
            SizedBox(height: screenHeight * 0.05),
            // 그룹
            Flexible(
              flex: 3,
              child: swiper ??
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            ),
            SizedBox(
              height: screenHeight * 0.13,
            )
          ],
        ),
        bottomNavigationBar: const BottomNav(),
      ),
    );
  }

  Future<dynamic> _newGroupModal(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          title: const Text(
            "그룹 생성",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  var picker = ImagePicker();
                  var image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      userImage = File(image.path);
                    });
                  }
                  print("123");
                },
                child: Image.asset("assets/images/camera.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                    isDense: true,
                    fillColor: Color(0xffD9D9D9),
                    filled: true,
                    hintText: '그룹 이름을 입력해 주세요',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 5)),
                    prefixIcon: const Icon(
                      Icons.edit,
                      size: 16,
                    )),
              ),
            ],
          ),
          insetPadding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
          actions: [
            TextButton(
              child: const Text('참여하기'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                disabledForegroundColor:
                    Colors.grey.withOpacity(0.38), // 버튼이 disable 상태일 때의 색상
              ),
              onPressed: () {
                // 참여하기 버튼을 눌렀을 때의 동작을 정의합니다.
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final TextEditingController codeController =
                        TextEditingController();
                    return AlertDialog(
                      title: const Text('참여하기'),
                      content: TextField(
                        controller: codeController,
                        decoration: InputDecoration(
                          hintText: '코드 4자리를 입력하세요',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4), // 최대 길이를 4로 제한
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('입장하기'),
                          onPressed: () {
                            int code = int.parse(codeController.text);

                            print(code); // 콘솔에 입력된 코드 출력. 실제로는 필요한 동작을 추가해야 함.
                            sendPostRequest(code);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            TextButton(
              child: const Text(
                '만들기',
              ),
              onPressed: () {
                setState(() {
                  inputText = inputController.text;
                });
                postRequest(inputText);
                Navigator.pop(context);
                // 여기서 원하는 방식으로 페이지를 새로 고침하거나 업데이트
              },
            ),
          ],
        );
      },
    );
  }
}
