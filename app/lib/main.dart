import 'package:app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/group_screen.dart';

void main() {
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
        home: const GroupScreen());
  }
}
