import 'package:flutter/material.dart';

class GroupMember extends StatelessWidget {
  const GroupMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '멤버',
                          style: TextStyle(fontSize: 30),
                        ),
                        Icon(
                          Icons.add_circle_outline_rounded,
                          size: 40,
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '검색어를 입력하세요',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    )
                  ],
                )),
            const SizedBox(
              height: 30,
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
                child: const Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '김창영',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '노준호',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '여도현',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '최종욱',
                            style: TextStyle(fontSize: 20),
                          ),
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
      ),
    );
  }
}
