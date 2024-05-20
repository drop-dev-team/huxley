import 'package:flutter/material.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class OrDividerWidget extends StatelessWidget {
  
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _responsiveSizer.spacingSize(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ),
            const Text("OR"),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: _responsiveSizer.spacingSize(context),
        ),
      ],
    );
  }
}
