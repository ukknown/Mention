// ignore_for_file: avoid_print, unused_import, unnecessary_string_interpolations
// import 'dart:convert';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:app/Screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:app/widgets/login_platform.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 94B8EB
class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  Future<String> loadtoken() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    return prefs.getString('token') ?? '';
  }

  LoginPlatform _loginPlatform = LoginPlatform.none;
  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      print("보내는 토큰 : ${token.accessToken}");

      final loginUrl =
          Uri.parse("http://k8c105.p.ssafy.io:8000/member-service/login");

      final data = {"token": token.accessToken};
      final jsonData = jsonEncode(data);

      final response = await http.post(
        loginUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _loginPlatform = LoginPlatform.kakao;
        });

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseData["accessToken"]);

        // final prefs = await SharedPreferences.getInstance();
        print(prefs.getString("token"));
        // print(responseData["accessToken"]);
      } else {
        print('에러 : ${response.statusCode}');
      }
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        break;
      case LoginPlatform.google:
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
    }
    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
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
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Image.asset(
                'assets/images/main.png',
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  signInWithKakao();
                  // loadtoken();
                  _loginPlatform == LoginPlatform.kakao
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        )
                      : null;
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(children: [
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 1),
                        child: Image.asset(
                          'assets/images/kakao.png',
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("|"),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("카카오톡으로 회원가입"),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
