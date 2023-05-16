import 'package:app/api/profile_api.dart';
import 'package:app/api/profile_model.dart';
import 'package:app/widgets/bg_img.dart';
import 'package:app/widgets/bottom_nav.dart';
import 'package:app/widgets/profile/profile_box/my_group.dart';
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
  Future<List<Group>> _loadGroups() async {
    return ProfileApi.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      body: Container(
        decoration: bgimg(),
        child: Center(
          child: FutureBuilder(
            future: _loadGroups(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
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
                        "그룹을 불러오는데 실패했어요!\n잠시 후에 다시 시도해주세요!",
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
                List<dynamic> groups = snapshot.data!;
                if (groups.isEmpty) {
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
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: widget.screenHeight * 0.01,
                          ),
                          itemCount: groups.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: widget.screenHeight * 0.01,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.screenWidth * 0.1,
                              ),
                              child: MyGroup(
                                screenHeight: widget.screenHeight,
                                screenWidth: widget.screenWidth,
                                groupId: groups[index].groupId,
                                groupImage: groups[index].groupImage,
                                groupName: groups[index].groupName,
                                groupMember: groups[index].groupMember,
                              ),
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
      ),
    );
  }
}
