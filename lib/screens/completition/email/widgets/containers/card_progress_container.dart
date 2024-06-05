import 'package:flutter/material.dart';

import '../progress/progress_base_indicator_widget.dart';

class CardProgressContainer extends StatefulWidget {
  final int numberOfSteps;
  final double nodeSize;
  final int currentNode;

  const CardProgressContainer({
    super.key,
    required this.numberOfSteps,
    required this.nodeSize,
    required this.currentNode,
  });

  @override
  State<CardProgressContainer> createState() => _CardProgressContainerState();
}

class _CardProgressContainerState extends State<CardProgressContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,  // Adds shadow under the card for better emphasis
      margin: const EdgeInsets.all(10),  // Adds space around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),  // Rounded corners for a smoother look
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),  // Inner padding within the card
        child: ProgressBarWidget(
          numberOfSteps: widget.numberOfSteps,
          nodeSize: widget.nodeSize,
          currentNode: widget.currentNode,
        ),
      ),
    );
  }
}
