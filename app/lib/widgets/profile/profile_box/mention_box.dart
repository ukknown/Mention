import 'package:app/screens/Hint.dart';
import 'package:flutter/material.dart';

class MentionBox extends StatefulWidget {
  const MentionBox({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.mentionId, //멘션아이디
    required this.topicTitle,
    required this.hintStep,
    required this.gender,
    required this.emoji,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final int mentionId;
  final String topicTitle;
  final int hintStep;
  final String gender;
  final int emoji;

  @override
  State<MentionBox> createState() => _MentionBoxState();
}

class _MentionBoxState extends State<MentionBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.screenHeight * 0.01),
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (BuildContext context) => Hint(
                mentionId: widget.mentionId,
              ),
            ),
          )
              .then((value) {
            setState(() {});
          });
          // print(widget.mentionId);
        },
        child: Container(
          width: widget.screenWidth * 0.8,
          decoration: BoxDecoration(
            color: genderColor(),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: widget.screenWidth * 0.65,
                    height: widget.screenHeight * 0.025,
                  ),
                  hintCounter(),
                ],
              ),
              SizedBox(
                height: widget.screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.screenWidth * 0.06,
                ),
                child: Text(
                  '${String.fromCharCode(widget.emoji)} ${widget.topicTitle}',
                  style: TextStyle(
                    fontSize: widget.screenWidth * 0.05,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: widget.screenHeight * 0.025,
              )
            ],
          ),
        ),
      ),
    );
  }

  Color genderColor() {
    if (widget.gender == "male") {
      return const Color(0xFFA3B3F9);
    } else if (widget.gender == "female") {
      return const Color(0xFFFEB6C4);
    } else {
      return const Color(0xFFFFFFFF);
    }
  }

  Widget hintCounter() {
    return Row(
      children: [
        Container(
          width: widget.screenWidth * 0.025,
          height: widget.screenWidth * 0.025,
          decoration: BoxDecoration(
            color: widget.hintStep > 0
                ? Color.fromARGB(255, 204, 255, 0)
                : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: widget.screenWidth * 0.02,
        ),
        Container(
          width: widget.screenWidth * 0.025,
          height: widget.screenWidth * 0.025,
          decoration: BoxDecoration(
            color: widget.hintStep > 1
                ? Color.fromARGB(255, 204, 255, 0)
                : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: widget.screenWidth * 0.02,
        ),
        Container(
          width: widget.screenWidth * 0.025,
          height: widget.screenWidth * 0.025,
          decoration: BoxDecoration(
            color: widget.hintStep > 2
                ? Color.fromARGB(255, 204, 255, 0)
                : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
