import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../containers/view_routes_calendar.dart';
import 'package:calendar_view/calendar_view.dart';

enum CalendarViewType { day, week, month }

class CalendarViewController extends GetxController {
  EventController calendarController = EventController();

  Rx<CalendarViewType> currentView = CalendarViewType.day.obs;

  void changeView(CalendarViewType viewType) {
    currentView.value = viewType;
  }

  Widget get currentViewWidget {
    return getViewForType(currentView.value);
  }

  Widget getViewForType(CalendarViewType viewType) {
    switch (viewType) {
      case CalendarViewType.day:
        return const DayViewWrapper();
      case CalendarViewType.week:
        return const WeekViewWrapper();
      case CalendarViewType.month:
        return const MonthViewWrapper();
      default:
        return const DayViewWrapper();
    }
  }
}
