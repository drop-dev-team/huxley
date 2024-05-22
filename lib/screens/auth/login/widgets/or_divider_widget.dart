import 'package:flutter/material.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class OrDividerWidget extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();

  OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely fetch the size with fallback values
    Size size = _responsiveSizer.orDividerSize(context);

    // Ensure that width and height are within reasonable limits
    double safeWidth = size.width.clamp(50.0, MediaQuery.of(context).size.width);
    double safeHeight = size.height.clamp(10.0, 50.0);  // Example range: minimum 10, maximum 50

    return SizedBox(
      width: size.width ?? safeWidth,
      height: size.height ?? safeHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: safeWidth / 2 - 20, // Allocate half of the width to one divider, minus some padding for the "OR" text
            child: const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("OR"),
          ),
          SizedBox(
            width: safeWidth / 2 - 20, // Same as the first divider
            child: const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
