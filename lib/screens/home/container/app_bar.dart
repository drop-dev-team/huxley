import 'package:flutter/material.dart';

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  // AppBar properties
  final Color backgroundColor; // Background color of the AppBar
  final Text title; // Title Widget of the AppBar
  final List<Widget>? actions; // Actions (typically Icons) on the right side of the AppBar

  // Constructor with named parameters and default values
  const myAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.red, // Default color is red, can be overridden
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  // Define the AppBar's preferred size
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard height for toolbars in material design
}
