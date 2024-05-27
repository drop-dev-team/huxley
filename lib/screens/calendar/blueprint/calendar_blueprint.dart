import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../containers/expandable_calendar_view_container.dart';
import '../controllers/calendar_view_controller.dart'; // Make sure this points to your CustomExpandable widget

class CalendarBlueprint extends StatelessWidget {
  const CalendarBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarViewController controller =
        Get.find<CalendarViewController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_view_day),
              onPressed: () => controller.changeView(CalendarViewType.day),
              tooltip: 'Day View',
            ),
            IconButton(
              icon: const Icon(Icons.calendar_view_week),
              onPressed: () => controller.changeView(CalendarViewType.week),
              tooltip: 'Week View',
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => controller.changeView(CalendarViewType.month),
              tooltip: 'Month View',
            ),
          ],
        ),
        Expanded(
          child: Obx(() => CustomExpandable(
                header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                        'Current View: ${controller.currentView.toString().split('.').last.capitalizeFirst}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                content: controller.currentViewWidget,
              )),
        ),
      ],
    );
  }
}
