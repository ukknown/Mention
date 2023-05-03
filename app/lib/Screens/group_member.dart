import 'package:flutter/material.dart';

class GroupMember extends StatelessWidget {
  const GroupMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '멤버',
                          style: TextStyle(fontSize: 30),
                        ),
                        Icon(
                          Icons.add_circle_outline_sharp,
                          size: 40,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '이름 검색',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 5)),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 16,
                            )),
                      ),
                    )
                  ],
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
                child: const SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      member(),
                      member(),
                      member(),
                      member(),
                      member(),
                      member(),
                    ],
                  ),
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
