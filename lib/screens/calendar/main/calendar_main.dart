import 'package:flutter/material.dart';
import 'package:huxley/screens/home/container/app_bar.dart';

import '../blueprint/calendar_blueprint.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const SafeArea(
        child: CalendarBlueprint(),
      )
    );
  }
}
