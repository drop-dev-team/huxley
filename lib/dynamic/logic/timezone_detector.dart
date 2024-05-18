import 'package:flutter/material.dart';
import 'dart:async';

enum TimeOfDaySegment { morning, noon, afternoon, night }

class TimeOfDayDetector extends ChangeNotifier {
  TimeOfDaySegment? _currentSegment;
  Timer? _timer;

  TimeOfDayDetector() {
    _currentSegment = _getTimeOfDaySegment();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndUpdateTimeOfDay();
    });
  }

  TimeOfDaySegment? get currentSegment => _currentSegment;

  void _checkAndUpdateTimeOfDay() {
    var newSegment = _getTimeOfDaySegment();
    if (newSegment != _currentSegment) {
      _currentSegment = newSegment;
      notifyListeners();
    }
  }

  static TimeOfDaySegment _getTimeOfDaySegment() {
    var now = DateTime.now();
    var hour = now.hour;
    if (hour >= 6 && hour < 12) return TimeOfDaySegment.morning;
    if (hour >= 12 && hour < 14) return TimeOfDaySegment.noon;
    if (hour >= 14 && hour < 18) return TimeOfDaySegment.afternoon;
    return TimeOfDaySegment.night;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
