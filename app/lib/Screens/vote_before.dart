import 'package:flutter/material.dart';
import 'package:app/Screens/vote_after.dart';

class VoteMember extends StatelessWidget {
  const VoteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const Flexible(
              flex: 3,
              child: Text(
                '오늘 행복해 보이는 사람',
                style: TextStyle(fontSize: 30),
              )),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            flex: 5,
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VotePick()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text('김창영'),
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('노준호'),
                      ],
                    ),
                  ),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('여도현'),
                      ],
                    ),
                  ),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('최종욱'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Flexible(flex: 1, child: Text('이동 바'))
        ],
      ),
    );
  }
}
