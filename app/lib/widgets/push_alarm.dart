import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TestNotificationPage extends StatefulWidget {
  const TestNotificationPage({super.key});

  @override
  _TestNotificationPageState createState() => _TestNotificationPageState();
}

class _TestNotificationPageState extends State<TestNotificationPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showTestNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Mention', '누군가 당신에게 멘션을 보냈습니다.', platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('테스트 알림을 표시하려면 아래 버튼을 누르세요.'),
            const SizedBox(height: 16), 
            ElevatedButton(
              onPressed: showTestNotification,
              child: const Text('알림 표시'),
            ),
          ],
        ),
      ),
    );
  }
}
