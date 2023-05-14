import 'package:app/Screens/vote_after.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class VoteMember extends StatelessWidget {
  const VoteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: bgimg(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '오늘 행복해 보이는 사람',
                      style: TextStyle(fontSize: 30),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 4,
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Member(),
                            Member(),
                            Member(),
                            Member(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class Member extends StatelessWidget {
  const Member({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMentionModal(context),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: CircleAvatar(
                  radius: 40,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    '김창영',
                    style: TextStyle(fontSize: 25),
                  )),
              // Expanded(flex: 1, child: Icon(Icons.person))
            ],
          ),
        ),
      ),
    );
  }
}

void _showMentionModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('김창영님을 멘션할까요?'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VotePick()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightGreen,
              ),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text('No'),
            ),
          ],
        ),
      );
    },
    barrierDismissible: true,
  );
}
