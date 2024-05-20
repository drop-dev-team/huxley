import 'package:flutter/material.dart';

class HyperLinkRoutingWidget extends StatelessWidget {
  final String initialTextLeftSide;
  final String hyperLinkHintText;
  final VoidCallback onTap; // Callback for tap action

  const HyperLinkRoutingWidget({
    super.key,
    required this.initialTextLeftSide,
    required this.hyperLinkHintText,
    required this.onTap, // Required onTap function
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(initialTextLeftSide),
        GestureDetector(
          onTap: onTap, // Use the onTap function passed in as a parameter
          child: Text(
            " $hyperLinkHintText",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ],
    );
  }
}
