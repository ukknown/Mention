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
  int _stepCount = 3000;
  bool _showFireworks = false;
  bool _showClick = true;

  @override
  void initState() {
    super.initState();
    // _initPedometer();
  }

  void _resetStepCount() {
    setState(() {
      _stepCount = 0;
    });
  }

  void _displayFireworks() async {
    setState(() {
      _showFireworks = true;
      _showClick = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _showFireworks = false;
    });

    _resetStepCount();
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
                  width: widget.screenWidth * 0.1,
                ),
              ),
              if (_showClick && isComplete)
                Lottie.asset(
                  'assets/animations/click.json',
                  width: widget.screenWidth * 0.12,
                ),
              if (_showFireworks)
                Transform.scale(
                  scale: 3.0, // 원하는 스케일 값으로 변경하세요.
                  child: Transform.translate(
                    offset: Offset(-widget.screenWidth * 0.01, 0),
                    child: Lottie.asset(
                      'assets/animations/fireworks.json',
                      width: widget.screenWidth * 0.1,
                    ),
                  ),
                ),
              InkWell(
                onTap: isComplete ? _displayFireworks : null,
                child: Container(
                  width: widget.screenWidth * 0.15,
                  height: widget.screenHeight * 0.05,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
