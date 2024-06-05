import 'package:flutter/material.dart';

import 'edge_helper.dart';
import 'node_helper.dart';

class ProgressBarWidget extends StatefulWidget {
  final int numberOfSteps;
  final double nodeSize;
  final int currentNode;

  const ProgressBarWidget({
    super.key,
    required this.numberOfSteps,
    this.nodeSize = 50.0,
    this.currentNode = 1,
  });

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.numberOfSteps - 1, (index) {
        return Expanded(
          child: Row(
            children: [
              NodeWidget(
                isCurrent: index == widget.currentNode - 1,
                isCompleted: index < widget.currentNode,
                nodeSize: widget.nodeSize,
              ),
              if (index <= widget.numberOfSteps)
                Expanded(
                  child: AnimatedEdgeWidget(
                    isActive: index < widget.currentNode,
                  ),
                ),
            ],
          ),
        );
      })
        ..add(
          NodeWidget(
            isCurrent: widget.numberOfSteps == widget.currentNode,
            isCompleted: widget.numberOfSteps <= widget.currentNode,
            nodeSize: widget.nodeSize,
          ),

        ),
    );
  }
}
