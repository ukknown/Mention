import 'dart:convert';
import 'package:app/widgets/profile/profile_box/my_group.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  final double screenWidth, screenHeight;

  const GroupList({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  Future<List<dynamic>> _loadGroups() async {
    String jsonString = await rootBundle.loadString('lib/api/group_list.json');
    final jsonData = json.decode(jsonString);
    return jsonData['group'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffAAC6EF),
      body: Center(
        child: FutureBuilder(
          future: _loadGroups(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<dynamic> groups = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: widget.screenHeight * 0.08,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.screenWidth * 0.05,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/group.png',
                          width: widget.screenWidth * 0.15,
                        ),
                        SizedBox(
                          width: widget.screenWidth * 0.05,
                        ),
                        Text(
                          "내 그룹",
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
                  for (var group in groups)
                    MyGroup(
                      screenHeight: widget.screenHeight,
                      screenWidth: widget.screenWidth,
                      groupId: group['group_id'],
                      groupImage: group["group_image"],
                      groupName: group["group_name"],
                      groupMember: group["group_member"],
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
