// ignore: duplicate_ignore
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:app/Screens/mainPage.dart';
import 'package:app/Screens/notice_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fcmSetting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// 앱이 종료된 상태에서 알림 클릭 시 이동을 위해 필요한 navigatorKey
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? firebaseToken = await fcmSetting();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isRead')) {
    await prefs.setStringList('isRead', []);
  }
  KakaoSdk.init(nativeAppKey: 'fdb226da9bdf3e5030a432d9f509a01a');
  await AndroidAlarmManager.initialize();

  runApp(new Mention());

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
    navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => NoticePage()));
  } // onSelectNotification 콜백 설정
      );

  NotificationAppLaunchDetails? details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (details != null && details.didNotificationLaunchApp) {
    selectNotification('이동해라 얍');
  }
}

Future selectNotification(String? payload) async {
  // Handle notification tap
  if (payload != null && payload.isNotEmpty) {
    navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => NoticePage()));
  }
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
      navigatorKey: navigatorKey, // Add navigatorKey
      home: const MainPage(),
    );
  }
}
