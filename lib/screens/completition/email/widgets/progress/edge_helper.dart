import 'package:flutter/material.dart';

class AnimatedEdgeWidget extends StatefulWidget {
  final bool isActive;

  const AnimatedEdgeWidget({super.key, this.isActive = false});

  @override
  State<AnimatedEdgeWidget> createState() => _AnimatedEdgeWidgetState();
}

class _AnimatedEdgeWidgetState extends State<AnimatedEdgeWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400), 
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    if (widget.isActive) {
      _controller?.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedEdgeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller?.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller?.reverse();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: _animation!.value, 
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
