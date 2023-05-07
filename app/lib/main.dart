import 'package:app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const Mention());
}

class Mention extends StatelessWidget {
  const Mention({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        home: const ProfilePage());
  }
}
