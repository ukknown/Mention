// ignore: duplicate_ignore
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:app/Screens/mainPage.dart';
import 'package:app/Screens/notice_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isRead')) {
    await prefs.setStringList('isRead', []);
  }
  KakaoSdk.init(nativeAppKey: 'fdb226da9bdf3e5030a432d9f509a01a');
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(new Mention());
}

class Mention extends StatelessWidget {
  const Mention({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFABC6EF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const NoticePage(),
    );
  }
}
