import 'package:flutter/material.dart';

class CustomExpandable extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool initiallyExpanded;

  const CustomExpandable({
    super.key,
    required this.header,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  State<CustomExpandable> createState() => _CustomExpandableState();
}

class _CustomExpandableState extends State<CustomExpandable> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: toggleExpansion,
          child: widget.header,
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: isExpanded ? widget.content : Container(),
          ),
        ),
      ],
    );
  }
}
