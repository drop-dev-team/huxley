import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor: Colors.grey[200],
              iconTheme: WidgetStateProperty.all(
                const IconThemeData(color: Colors.black),
              ),
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ),
          child: NavigationBar(
            height: 50,
            elevation: 1,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.houseCircleCheck), label: ''),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.solidCalendarDays), label: ''),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.chartSimple), label: ''),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.magnifyingGlass), label: ''),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.solidComments), label: ''),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}
