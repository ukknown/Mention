import 'package:flutter/material.dart';
import 'dart:ui';

class CoinButton extends StatelessWidget {
  const CoinButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.coin,
  });

  final double screenWidth, screenHeight;
  final int coin;

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide.none,
                ),
                elevation: 5,
                backgroundColor: const Color(0xFFFF9800),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/sandclock.gif',
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        "준비 중",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModal(context),
      child: Column(
        children: [
          Image.asset(
            'assets/images/coin.png',
            height: screenWidth * 0.125,
            width: screenWidth * 0.125,
          ),
          Text(
            "$coin",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
