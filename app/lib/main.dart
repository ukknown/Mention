import 'package:app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Mention());
}

class Mention extends StatelessWidget {
  const Mention({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}
