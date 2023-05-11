import 'package:app/api/notice_model.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/profile/profile_box/notice_box.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Future<NoticeList> _loadNoticeList() async {
    String jsonString = await rootBundle.loadString('lib/api/notice.json');
    final jsonResponse = json.decode(jsonString);
    return NoticeList.fromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      bottomNavigationBar: const BottomNav(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: FutureBuilder<NoticeList>(
            future: _loadNoticeList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final String name = snapshot.data!.name;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.08,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/bell.png',
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Text(
                          "알림",
                          style: TextStyle(
                            fontSize: screenWidth * 0.1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.notices.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: screenHeight * 0.01),
                        itemBuilder: (context, index) {
                          var notice = snapshot.data!.notices[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            child: NoticeBox(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              name: name,
                              notice: notice,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
