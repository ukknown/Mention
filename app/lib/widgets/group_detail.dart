// ignore_for_file: unused_field

import 'dart:async';
import 'package:app/Screens/vote_before.dart';
import 'package:flutter/material.dart';

import '../api/group_model.dart';

class GroupDetail extends StatefulWidget {
  final String topicTitle;
  final String dueDate;
  final int capacity;
  final List<MemberModel> memberList;
  final int index;
  final int participant;
  final int voteId;

  GroupDetail(
      {required this.topicTitle,
      required this.memberList,
      required this.dueDate,
      required this.capacity,
      required this.index,
      required this.participant,
      required this.voteId,
      Key? key})
      : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late Timer _timer;
  late DateTime _dueDate;
  late int _elapsedTime;

  @override
  void initState() {
    super.initState();
    _dueDate = DateTime.parse(widget.dueDate);
    _elapsedTime = 0;
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
    print(widget.dueDate);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration remainingTime = _dueDate.difference(DateTime.now());
    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes.remainder(60);
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
          // print(widget.memberList);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (VoteMember(
                      memberList: widget.memberList,
                      topicTitle: widget.topicTitle,
                      voteId: widget.voteId))));
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
            Expanded(
                flex: 1,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  widget.topicTitle,
                  style: TextStyle(fontSize: 20),
                )),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_rounded),
                  Text(
                    '${widget.participant} / ${widget.capacity}',
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
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   '${widget.index + 1} of maxindex}',
            //   style: TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
    );
  }
}
