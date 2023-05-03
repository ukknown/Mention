import 'package:flutter/material.dart';

class VoteMember extends StatelessWidget {
  const VoteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
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
                    member(),
                    member(),
                    member(),
                    member(),
                  ],
                ),
              ),
            ),
            const Expanded(flex: 1, child: Text('이동 바'))
          ],
        ),
      ),
    );
  }
}

class member extends StatelessWidget {
  const member({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
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
    );
  }
}
