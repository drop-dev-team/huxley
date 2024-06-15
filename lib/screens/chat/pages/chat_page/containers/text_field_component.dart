import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';  // For ImageFilter and context for ThemeData
import 'dart:ui';  // Required for ImageFilter

class InputFieldComponent extends StatefulWidget {
  final Function(String) onSendPressed;  // Define onSendPressed as taking a String

  const InputFieldComponent({super.key, required this.onSendPressed});

  @override
  State<InputFieldComponent> createState() => _InputFieldComponentState();
}

class _InputFieldComponentState extends State<InputFieldComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),  // Padding around the main container
      child: Row(
        children: [
          CupertinoButton(
            onPressed: () => print("Plus icon pressed"),  // Placeholder function
            padding: EdgeInsets.zero,  // Remove default padding
            minSize: 0,
            child: const Icon(CupertinoIcons.plus_circle_fill, color: CupertinoColors.systemGrey),  // Plus icon
          ),
          const SizedBox(width: 10),  // Space between the plus button and the text field
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),  // Rounded corners
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),  // Increase the blur effect
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6.withOpacity(0.5),  // Semi-transparent background
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: CupertinoTextField(
                    controller: _controller,
                    placeholder: 'Text message',
                    decoration: BoxDecoration(
                      color: Colors.transparent,  // Clear background to let the blur show through
                      borderRadius: BorderRadius.circular(18.0), // Rounded corners for the text field
                    ),
                    style: const TextStyle(color: CupertinoColors.black),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    onChanged: (text) => setState(() {}),  // Trigger rebuild on text change
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),  // Space between the text field and the button
          CupertinoButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSendPressed(_controller.text);
                _controller.clear();
              }
            },
            padding: EdgeInsets.zero,
            minSize: 0,
            child: Icon(
              _controller.text.isEmpty ? CupertinoIcons.mic_fill : CupertinoIcons.arrow_up_circle_fill,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }
}
