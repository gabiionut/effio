import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends ChangeNotifier {
  Timer? timer;
  Duration duration = const Duration();
  bool isRunning = false;

  void reset() {
    duration = const Duration();
    notifyListeners();
  }

  void startTimer({Duration duration = const Duration(seconds: 1)}) {
    stopTimer();
    timer = Timer.periodic(duration, (_) => addTime());
    isRunning = true;
    notifyListeners();
  }

  void addTime() {
    const addSeconds = 1;
    final seconds = duration.inSeconds + addSeconds;
    duration = Duration(seconds: seconds);
    notifyListeners();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    isRunning = false;
    timer?.cancel();
    notifyListeners();
  }

  // pause timer
  void pauseTimer() {
    timer?.cancel();
    isRunning = false;
    notifyListeners();
  }

  // resume timer
  void resumeTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    isRunning = true;
    notifyListeners();
  }
}
