import 'package:flutter/material.dart';

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
    return Padding(
      padding: EdgeInsets.only(
        top: widget.screenHeight * 0.01,
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
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${percentage.toInt()}%',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text('획득'),
          ),
        ],
      ),
    );
  }
}
