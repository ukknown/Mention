import 'package:app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/profile/profile_page.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app/screens/Hint.dart';
import 'package:app/screens/group_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> imgList = [
    'assets/images/completetoday.png',
    'assets/images/tomention.png',
    'assets/images/topic.png',
    'assets/images/cashwalk.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/backgroundBall.png',
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                flex: 1,
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text("다음으로"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Hint(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(imgList[index]

                        // fit: BoxFit.fill,
                        );
                  },
                  onTap: (index) {
                    // debugPrint(imgList[index]);
                    imgList[index] == "assets/images/cashwalk.png"
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          )
                        : Null;
                  },
                  // autoplay: true,
                  itemCount: imgList.length,
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.all(20),
                  ),
                  // control: const SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                flex: 5,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GroupScreen()));
                      },
                      child: Image.asset(
                        "assets/images/mainCard.png",
                        // fit: BoxFit.fill,
                      ),
                    );
                    // return Image.asset(
                    //   "assets/images/mainCard.png",
                    //   // fit: BoxFit.fill,
                    // );
                  },
                  // itemHeight: 500,
                  // itemWidth: 500,
                  itemCount: 3,
                  viewportFraction: 0.8,
                  scale: 0.81,
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.all(0.0),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              )
            ],
          ),
          bottomNavigationBar: const BottomNav()),
    );
  }
}
