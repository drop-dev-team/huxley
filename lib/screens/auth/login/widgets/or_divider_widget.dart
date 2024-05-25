import 'package:flutter/material.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class OrDividerWidget extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();

  OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = _responsiveSizer.orDividerSize(context);

    double safeWidth =
        size.width.clamp(50.0, MediaQuery.of(context).size.width);
    double safeHeight = size.height.clamp(10.0, 50.0);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: safeWidth / 2 - 20,
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
            width: safeWidth / 2 - 20,
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
