import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/timezone_detector.dart';

class TimeOfDayObserver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listening to TimeOfDayDetector
    var timeOfDay = context.watch<TimeOfDayDetector>().currentSegment;

    return Scaffold(
      appBar: AppBar(title: Text('Time of Day Observer')),
      body: Center(
        child: Text(
          'Current Time of Day: ${timeOfDay.toString().split('.').last}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
