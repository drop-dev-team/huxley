import 'package:flutter/material.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class InputTextFieldWidget extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  final String? hintText;

  InputTextFieldWidget({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: _responsiveSizer.textSize(context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
