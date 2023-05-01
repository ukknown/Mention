import 'package:app/screens/received_mentions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Mention());
}

class Mention extends StatelessWidget {
  const Mention({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ReceivedMentions(),
    );
  }
}
