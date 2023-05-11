import 'dart:convert';
import 'package:app/widgets/profile/profile_box/mention_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Future<List<dynamic>> loadMentionsData() async {
    final jsonString =
        await rootBundle.loadString('lib/api/received_mentions.json');
    final jsonData = json.decode(jsonString);
    return jsonData['mentions'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: FutureBuilder<List<dynamic>>(
        future: loadMentionsData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> mentions) {
          if (mentions.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (mentions.hasError) {
            return Center(child: Text('Error: ${mentions.error}'));
          } else {
            print(mentions);
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
                SizedBox(
                  height: widget.screenHeight * 0.02,
                ),
                for (var mention in mentions.data!)
                  MentionBox(
                    screenWidth: widget.screenWidth,
                    screenHeight: widget.screenHeight,
                    topicId: mention['topic_id'],
                    topicTitle: mention['topic_title'],
                    gender: mention['gender'],
                    hint: mention['hint'],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
