import 'dart:async';
import 'package:app/Screens/vote_before.dart';
import 'package:flutter/material.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({
    super.key,
  });

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late Timer _timer;
  late int _startTime;
  late int _elapsedTime;

  @override
  void initState() {
    super.initState();
    // _startTime = DateTime.now().hour * 60 + DateTime.now().minute;
    _startTime = 23 * 60 + 59;
    _elapsedTime = 0;
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = (_startTime ~/ 60 - _elapsedTime ~/ 60) % 24;
    int minutes = (_startTime % 60 - _elapsedTime % 60) % 60;
    String timeString = '$hours:${minutes.toString().padLeft(2, '0')}';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (const VoteMember())));
        },
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/meet.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Expanded(
                flex: 1,
                child: Text(
                  '밥 먹어보고 싶은 사람',
                  style: TextStyle(fontSize: 20),
                )),
            const Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_rounded),
                  Text(
                    '15/24',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/clock.png',
                  ),
                  Text(
                    timeString,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
