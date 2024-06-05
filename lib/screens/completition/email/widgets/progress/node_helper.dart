import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NodeWidget extends StatelessWidget {
  final bool isCurrent;
  final bool isCompleted;
  final double nodeSize;

  const NodeWidget({
    super.key,
    this.isCurrent = false,
    this.isCompleted = false,
    required this.nodeSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,  // Allow the icon to be positioned outside the container's bounds
      children: [
        Container(
          width: nodeSize,
          height: nodeSize,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCurrent
                ? const Icon(Icons.check, color: Colors.white)
                : isCompleted
                ? const Icon(Icons.check, color: Colors.white)
                : const SizedBox.shrink(),
          ),
        ),
        if (isCurrent) // Display the icon only if it's the current node
          const Positioned(
            top: -19,  // Adjust this value to position the icon directly above the node
            child: Icon(FontAwesomeIcons.caretDown, size: 22),
          ),
      ],
    );
  }
}
