import 'package:flutter/material.dart';

class VotePick extends StatelessWidget {
  const VotePick({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '오늘 행복해 보이는 사람',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              flex: 3,
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
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "My Mention",
                            style: TextStyle(fontSize: 50),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Image.asset('lib/assets/images/crown.png'),
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
            const Expanded(flex: 1, child: Center(child: Text('이동 바')))
          ],
        ),
      ),
    );
  }
}
