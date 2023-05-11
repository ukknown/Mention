import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedometerManager {
  Stream<StepCount>? _stepCountStream;
  int stepCount = 0;

  Future<void> init() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream?.listen(onData);
      _startBackgroundTask();
    }
  }

  void onData(StepCount event) {
    stepCount = event.steps;
    saveSteps(stepCount);
  }

  void _startBackgroundTask() async {
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 15),
      0,
      _backgroundTask,
      wakeup: true,
      exact: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> _backgroundTask() async {
    final pedometerManager = PedometerManager();
    final steps = await pedometerManager.loadSteps();
    await pedometerManager.saveSteps(steps);
    // 여기서 steps 값을 저장하거나 처리할 수 있습니다.
  }

  Future<void> saveSteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', steps);
  }

  Future<int> loadSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('steps') ?? 0;
  }
}
