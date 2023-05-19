// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class swipercontainer extends StatefulWidget {
  const swipercontainer({
    Key? key,
    required this.groupimg,
    required this.groupname,
    required this.membernum,
    required this.id,
    required this.vote,
    required this.screenWidth,
  }) : super(key: key);

  final String groupname;
  final int membernum;
  final dynamic groupimg;
  final int id;
  final List vote;
  final double screenWidth;
  @override
  State<swipercontainer> createState() => _swipercontainerState();
}

class _swipercontainerState extends State<swipercontainer> {
  @override
  Widget build(BuildContext context) {
    int emoji0;
    int emoji1;
    String topicTitle0;
    String topicTitle1;

    // Default emoji and title.
    int defaultEmoji = int.parse('1F614', radix: 16); // 😔 emoji
    String defaultTitle = "아직 토픽이 없어요!";

    switch (widget.vote.length) {
      case 0:
        emoji0 = defaultEmoji;
        emoji1 = defaultEmoji;
        topicTitle0 = defaultTitle;
        topicTitle1 = defaultTitle;
        break;
      case 1:
        emoji0 = int.tryParse(widget.vote[0]['emoji'] ?? '', radix: 16) ??
            defaultEmoji;
        emoji1 = defaultEmoji;
        topicTitle0 = widget.vote[0]['topicTitle'] ?? defaultTitle;
        topicTitle1 = defaultTitle;
        break;
      default:
        emoji0 = int.tryParse(widget.vote[0]['emoji'] ?? '', radix: 16) ??
            defaultEmoji;
        emoji1 = int.tryParse(widget.vote[1]['emoji'] ?? '', radix: 16) ??
            defaultEmoji;
        topicTitle0 = widget.vote[0]['topicTitle'] ?? defaultTitle;
        topicTitle1 = widget.vote[1]['topicTitle'] ?? defaultTitle;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      decoration: BoxDecoration(
        color: const Color(0xFFA3B3F9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: const Offset(4, 7),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: ClipOval(
                    child: Image.network(widget.groupimg),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.groupname,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "👤 ${widget.membernum}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.71,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C6EAE),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        '${String.fromCharCode(emoji0)}',
                        style: TextStyle(fontSize: widget.screenWidth * 0.09),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.71,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C6EAE),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.screenWidth * 0.05,
                      ),
                      child: Text(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        "${widget.vote[0]['topicTitle']}",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.71,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C6EAE),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        '${String.fromCharCode(emoji1)}',
                        style: TextStyle(fontSize: widget.screenWidth * 0.09),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.71,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C6EAE),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.screenWidth * 0.05,
                      ),
                      child: Text(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        "${widget.vote[1]['topicTitle']}",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
