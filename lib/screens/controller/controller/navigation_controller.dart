import 'package:get/get.dart';
import 'package:huxley/screens/chart/main/chart_main.dart';
import 'package:huxley/screens/chat/main/chat_main.dart';
import 'package:huxley/screens/home/main/home_screen.dart';
import 'package:huxley/screens/search/main/search_main.dart';

import '../../calendar/main/calendar_main.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    const HomeScreen(),
    const CalendarScreen(),
    const ChartScreen(),
    const SearchScreen(),
    const ChatScreen()
  ];
}