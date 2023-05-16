// ignore: duplicate_ignore
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:app/Screens/mainPage.dart';
import 'package:app/Screens/profile/group_list.dart';
import 'package:app/Screens/profile/profile_page.dart';
import 'package:app/Screens/profile/received_mentions.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: 'fdb226da9bdf3e5030a432d9f509a01a');
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(new Mention());
}

class Mention extends StatelessWidget {
  const Mention({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      // home: const MainPage());
      home: ProfilePage(),
    );
  }
}
