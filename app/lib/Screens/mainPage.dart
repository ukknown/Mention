// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:app/Screens/group_screen.dart';
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
  // final ImagePicker _picker = ImagePicker();
  // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  File? userImage;

  List<dynamic> swiperList = [];
  TextEditingController inputController = TextEditingController();
  String inputText = '';
  File? imageFile;
  late int propsId = -1;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

// JSON 데이터를 포함한 POST 요청 예시
  Future<void> postRequest() async {
    final url = Uri.parse('http://k8c105.p.ssafy.io:8000/team-service/teams');

    final jsonBody = jsonEncode(inputText);

    final response = await http.post(url, headers: <String, String>{
      // 'Content-Type': 'application/json', // Content-Type 설정
      'Authorization':
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q",
    }, body: {
      "name": jsonBody,
      "file": userImage,
    });

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

  void getProfile() async {
    const String baseUrl = 'http://k8c105.p.ssafy.io:8000';
    // final prefs = await SharedPreferences.getInstance();
    // late String accessToken = prefs.getString("token")!;

    final url = Uri.parse('${baseUrl}/team-service/teams');
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
        final List<dynamic> profileJson = jsonDecode(responseBody);
        List<dynamic> updatedSwiperList = [];
        for (dynamic group in profileJson) {
          // print(group);
          updatedSwiperList.add(swipercontainer(
            groupimg: group["image"],
            groupname: group["name"],
            membernum: group["capacity"],
            id: group["id"],
            vote: group["voteList"],
          ));
          print(group["voteList"][0]["topicTitle"]);
        }
        ;
        setState(() {
          updatedSwiperList.add(Image.asset(
            "assets/images/addgroup.png",
          ));
          swiperList = updatedSwiperList;
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
                  Row(children: [
                    Flexible(
                      flex: 6,
                      child: Container(),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                        child: Container(
                          child: IconButton(
                            icon: Icon(Icons.logout, size: 36),
                            onPressed: () {
                              getProfile();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Hint(),
                              //   ),
                              // );
                            },
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ]),
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
                  return swiperList[index];
                },
                onTap: (index) {
                  index == (swiperList.length - 1)
                      ? showDialog(
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
                                      var image = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (image != null) {
                                        setState(() {
                                          userImage = File(image.path);
                                        });
                                      }
                                      print("123");
                                    },
                                    child:
                                        Image.asset("assets/images/camera.png"),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextField(
                                    controller: inputController,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        fillColor: Color(0xffD9D9D9),
                                        filled: true,
                                        hintText: '그룹 이름을 입력해 주세요',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: Colors.green, width: 5)),
                                        prefixIcon: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        )),
                                  ),
                                ],
                              ),
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 60, 0, 60),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    '만들기',
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      inputText = inputController.text;
                                    });
                                    print(inputText);
                                    print(imageFile);
                                    postRequest();
                                  },
                                ),
                              ],
                            );
                          },
                        )
                      : setState(
                          () {
                            propsId = swiperList[index].id;
                          },
                        );
                  if (swiperList[index].id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupScreen(propsId),
                      ),
                    );
                    // print(swiperList[index].id);
                  }
                },
                itemCount: swiperList.length,
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
