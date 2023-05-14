import 'package:flutter/material.dart';
import 'package:app/screens/profile/profile_page.dart';
import 'package:card_swiper/card_swiper.dart';

// ignore: camel_case_types
class dailymissonswiper extends StatelessWidget {
  const dailymissonswiper({
    super.key,
    required this.imgList,
  });

  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Swiper(
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
    );
  }
}
