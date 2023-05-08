import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PedometerText extends StatefulWidget {
  final double screenHeight, screenWidth;

  const PedometerText({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  _PedometerTextState createState() => _PedometerTextState();
}

class _PedometerTextState extends State<PedometerText> {
  // final PedometerManager _pedometerManager = PedometerManager();
  final int _stepCount = 1500;

  @override
  void initState() {
    super.initState();
    // _initPedometer();
  }

  // void _initPedometer() async {
  //   try {
  //     await _pedometerManager.init();
  //     setState(() {
  //       _stepCount = _pedometerManager.stepCount;
  //     });
  //   } on PlatformException catch (e) {
  //     print("Error: ${e.message}");
  //     setState(() {
  //       _stepCount = 0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final percentage = _stepCount / 3000 * 100;
    final limitedPercentage = percentage > 100 ? 100 : percentage;
    final isComplete = percentage >= 100;
    return Padding(
      padding: EdgeInsets.only(
        top: widget.screenHeight * 0.01,
        left: widget.screenWidth * 0.025,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.screenWidth * 0.7,
            height: widget.screenHeight * 0.035,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: limitedPercentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${limitedPercentage.toInt()}%',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(-widget.screenWidth * 0.03, 0),
                child: Image.asset(
                  isComplete
                      ? 'assets/images/race-flag.png'
                      : 'assets/images/race-flag-watermark.png',
                  width: 50,
                  height: 50,
                ),
              ),
              if (isComplete)
                Lottie.asset(
                  'assets/animations/click.json',
                  width: 50,
                  height: 50,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
