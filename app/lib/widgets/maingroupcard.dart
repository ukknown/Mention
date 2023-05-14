// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class swipercontainer extends StatefulWidget {
  const swipercontainer({
    Key? key,
    required this.groupimg,
    required this.groupname,
    required this.membernum,
  }) : super(key: key);

  final String groupname;
  final int membernum;
  final dynamic groupimg;

  @override
  State<swipercontainer> createState() => _swipercontainerState();
}

class _swipercontainerState extends State<swipercontainer> {
  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(widget.groupimg),
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
                    child: Image.asset(
                      "assets/images/coin.png",
                      height: MediaQuery.of(context).size.height * 0.001,
                      width: MediaQuery.of(context).size.width * 0.001,
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
                    child: const Text(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      "가장 행복해 보이는 사람 생략 기능 추가",
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
                    child: Image.asset(
                      "assets/images/coin.png",
                      height: MediaQuery.of(context).size.height * 0.001,
                      width: MediaQuery.of(context).size.width * 0.001,
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
                    child: const Text(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      "가장 행복해 보이는 사람 생략 기능 추가",
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
