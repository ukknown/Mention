import 'package:flutter/material.dart';

BoxDecoration bgimg() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage(
        'assets/images/backgroundBall.png',
      ),
    ),
 
  );
}