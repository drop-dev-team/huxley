import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/timezone_detector.dart';

class TimeOfDayObserver extends StatelessWidget {
  const TimeOfDayObserver({super.key});

  @override
  Widget build(BuildContext context) {
    // Listening to TimeOfDayDetector
    var timeOfDay = context.watch<TimeOfDayDetector>().currentSegment;

    return Scaffold(
      appBar: AppBar(title: const Text('Time of Day Observer')),
      body: Center(
        child: Text(
          'Current Time of Day: ${timeOfDay.toString().split('.').last}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
