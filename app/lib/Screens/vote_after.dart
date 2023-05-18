// ignore_for_file: unused_import

import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
// import 'package:app/widgets/push_alarm.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VotePick extends StatefulWidget {
  final String nickname;
  final String avatarUrl;
  final int id;
  final String hint;
  final int voteId;
  const VotePick({
    required this.nickname,
    required this.avatarUrl,
    required this.id,
    required this.hint,
    required this.voteId,
    Key? key,
  }) : super(key: key);

  @override
  State<VotePick> createState() => _VotePickState();
}

class _VotePickState extends State<VotePick> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 15),
    );
    _controller.play();
    sendMention();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // sendMention();
    // print(widget.voteId);
    // print(widget.id);
    // print(widget.hint);
  }

  void sendMention() async {
    final url =
        Uri.parse('http://k8c105.p.ssafy.io:8000/mention-service/mentions');

    final body = {
      "voteId": widget.voteId,
      "pickerId": widget.id,
      "hint": widget.hint
    };

    final jsonBody = jsonEncode(body);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization':
            'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q',
        // "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ5ZGgxNTA5QGhhbm1haWwubmV0IiwiZW1haWwiOiJ5ZGgxNTA5QGhhbm1haWwubmV0Iiwibmlja25hbWUiOiLsl6zrj4TtmIQiLCJpYXQiOjE2ODQyODgzMjEsImV4cCI6MTY4Njg4MDMyMX0.hmjBNHeVhE9XkscASnC1shJxotK8wNWoumt4uUNXdgHRwPxTtWL6MzGZVGN9bXyaFIK5StjsZdqI8Iq_WtJJ5Q",
        'Content-Type': 'application/json', // JSON 형식으로 보내기 위한 헤더 추가
      },
      body: jsonBody,
    );

    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 요청을 보냈을 경우
      print('요청이 성공적으로 완료되었습니다.');
      print(response.body);
    } else {
      // 요청이 실패했을 경우
      print('요청이 실패하였습니다. 에러 코드: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Image.asset('assets/images/crown.png'),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //              GroupScreen()));
                                  },
                                  child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage:
                                          NetworkImage(widget.avatarUrl)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.nickname,
                                  style: TextStyle(fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              // position 위치
              // Positioned(
              //   top: MediaQuery.of(context).size.height /
              //       2, // Set the position to the middle vertically
              //   left: MediaQuery.of(context).size.width /
              //       2, // Set the position to the middle horizontally
              //   child: ConfettiWidget(
              //     confettiController: _controller,
              //     shouldLoop: true,
              //     blastDirection: pi, // 90 degrees (downwards)
              //     maxBlastForce: 50, // set a lower number for slower explosions
              //     minBlastForce: 25, // set a lower number for slower explosions
              //     emissionFrequency: 0.05, // how often it should emit particles
              //     numberOfParticles: 50, // number of particles to emit
              //     gravity:
              //         0.1, // adjust gravity value for desired particle falling speed
              //   ),
              // Positioned(
              //   top: MediaQuery.of(context).size.height * 1.1,
              //   left: MediaQuery.of(context).size.width * 1.1,
              //   child: _buildConfettiWidget(),
              // ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 1,
                child: _buildConfettiWidget(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1,
                left: MediaQuery.of(context).size.width * 0.3,
                child: _buildConfettiWidget(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1,
                left: MediaQuery.of(context).size.width * 1,
                child: _buildConfettiWidget(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

Widget _buildConfettiWidget() {
  ConfettiController localController = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  localController.play(); // Start the confetti animation

  return ConfettiWidget(
    confettiController: localController,
    // shouldLoop: true,
    blastDirection: pi, // 90 degrees (downwards)
    maxBlastForce: 40, // set a lower number for slower explosions
    minBlastForce: 20, // set a lower number for slower explosions
    emissionFrequency: 0.05, // how often it should emit particles
    numberOfParticles: 50, // number of particles to emit
    gravity: 0.1, // adjust gravity value for desired particle falling speed
  );
}
