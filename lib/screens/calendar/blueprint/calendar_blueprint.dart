import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calendar_view_controller.dart';

class CalendarBlueprint extends StatelessWidget {
  const CalendarBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarViewController controller = Get.find<CalendarViewController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_view_day),
            onPressed: () => controller.changeView(CalendarViewType.day),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_week),
            onPressed: () => controller.changeView(CalendarViewType.week),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => controller.changeView(CalendarViewType.month),
          ),
        ],
      ),
      body: Obx(() => controller.currentViewWidget),  // Correct placement of Obx
    );
  }
}
