// ignore_for_file: unused_field

import 'dart:async';
import 'package:app/Screens/vote_before.dart';
import 'package:flutter/material.dart';

import '../api/group_model.dart';

class GroupDetail extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String topicTitle;
  final int emoji;
  final String dueDate;
  final int capacity;
  final List<MemberModel> memberList;
  final int index;
  final int participant;
  final int voteId;

  GroupDetail({
    required this.screenWidth,
    required this.screenHeight,
    required this.topicTitle,
    required this.emoji,
    required this.memberList,
    required this.dueDate,
    required this.capacity,
    required this.index,
    required this.participant,
    required this.voteId,
    Key? key,
  }) : super(key: key);

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
                      emoji: widget.emoji,
                      voteId: widget.voteId))));
        },
        child: Padding(
          padding: EdgeInsets.all(widget.screenWidth * 0.05),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    '${String.fromCharCode(widget.emoji)}',
                    style: TextStyle(
                      fontSize: widget.screenWidth * 0.25,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      widget.topicTitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
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
      ),
    );
  }
}
