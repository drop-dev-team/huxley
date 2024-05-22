import 'package:flutter/material.dart';

class HyperLinkRoutingWidget extends StatelessWidget {
  final String initialTextLeftSide;
  final String hyperLinkHintText;
  final VoidCallback onTap;

  const HyperLinkRoutingWidget({
    super.key,
    required this.initialTextLeftSide,
    required this.hyperLinkHintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(initialTextLeftSide),
        GestureDetector(
          onTap: onTap,
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
