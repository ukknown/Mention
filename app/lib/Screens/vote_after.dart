import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class VotePick extends StatefulWidget {
  const VotePick({super.key});

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
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
                            offset: const Offset(0, 3),
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
                                const CircleAvatar(
                                  radius: 80,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  '김창영',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
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
