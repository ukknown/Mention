import 'package:app/api/profile_api.dart';
import 'package:app/api/profile_model.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/profile/profile_box/mention_box.dart';
import 'package:flutter/material.dart';

class ReceivedMentions extends StatefulWidget {
  final double screenHeight, screenWidth;

  const ReceivedMentions({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  _ReceivedMentionsState createState() => _ReceivedMentionsState();
}

class _ReceivedMentionsState extends State<ReceivedMentions> {
  Future<List<Mention>> loadMentionsData() async {
    return ProfileApi.getMentions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      body: Container(
        decoration: bgimg(),
        child: FutureBuilder<List<dynamic>>(
          future: loadMentionsData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> mentions) {
            if (mentions.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (mentions.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/warning_h.png',
                      width: widget.screenWidth * 0.50,
                    ),
                    SizedBox(
                      height: widget.screenHeight * 0.005,
                    ),
                    Text(
                      "받은 멘션을 불러오는데 실패했어요!\n잠시 후에 다시 시도해주세요!",
                      style: TextStyle(
                        fontSize: widget.screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            } else {
              if (mentions.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/warning_c.png',
                        width: widget.screenWidth * 0.50,
                      ),
                      SizedBox(
                        height: widget.screenHeight * 0.005,
                      ),
                      Text(
                        "아직 참여한 그룹이 없어요!",
                        style: TextStyle(
                          fontSize: widget.screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: widget.screenHeight * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidth * 0.1,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/group-chat.png',
                            width: widget.screenWidth * 0.2,
                          ),
                          SizedBox(
                            width: widget.screenWidth * 0.03,
                          ),
                          Text(
                            "받은 멘션",
                            style: TextStyle(
                              fontSize: widget.screenWidth * 0.1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: widget.screenHeight * 0.01,
                          horizontal: widget.screenWidth * 0.1,
                        ),
                        itemCount: mentions.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: widget.screenHeight * 0.01,
                        ),
                        itemBuilder: (context, index) {
                          var mention = mentions.data![index];
                          return MentionBox(
                            screenWidth: widget.screenWidth,
                            screenHeight: widget.screenHeight,
                            mentionId: mention.mentionId,
                            topicTitle: mention.topicTitle,
                            hintStep: mention.hintStep,
                            gender: mention.gender,
                            emoji: mention.emoji,
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
