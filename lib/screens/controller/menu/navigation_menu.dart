import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:ui'; // Import dart:ui to access ImageFilter

import '../controller/navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      extendBody: true, // Ensure the body extends behind the navigation bar
      bottomNavigationBar: Obx(
            () => ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX:10, sigmaY: 50), // Apply blur
            child: NavigationBar(
              backgroundColor: Colors.transparent.withOpacity(0.1), // Semi-transparent
              indicatorColor:Colors.grey[200],
              height: 75,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected, // Adjust label behavior
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: controller.selectedIndex.call,
              destinations: const [
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.houseCircleCheck), label: 'Home'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.solidCalendarDays), label: 'Calendar'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.chartSimple), label: 'Stats'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.magnifyingGlass), label: 'Search'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.solidComments), label: 'Messages'),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}
