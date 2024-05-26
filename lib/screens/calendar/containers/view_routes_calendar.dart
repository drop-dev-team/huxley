import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class DayViewWrapper extends StatelessWidget {
  const DayViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: DayView());
  }
}

class WeekViewWrapper extends StatelessWidget {
  const WeekViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: WeekView());
  }
}

class MonthViewWrapper extends StatelessWidget {
  const MonthViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: MonthView());
  }
}
