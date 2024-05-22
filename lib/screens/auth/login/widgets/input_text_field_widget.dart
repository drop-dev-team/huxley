import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class InputTextFieldWidget extends StatefulWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  final String? hintText;
  final double? width;
  final double? height;
  final bool isPassword;

  InputTextFieldWidget({
    super.key,
    this.hintText,
    this.width,
    this.height,
    required this.isPassword,
  });

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = widget.width ?? widget._responsiveSizer.textInputDimensions(context)[0];
    double textFieldHeight = widget.height ?? widget._responsiveSizer.textInputDimensions(context)[1];

    return Center(
      child: SizedBox(
        width: textFieldWidth,
        height: textFieldHeight,
        child: TextField(
          obscureText: widget.isPassword && _isObscured,
          keyboardType: widget.isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: widget._responsiveSizer.textSize(context)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: (textFieldHeight - widget._responsiveSizer.textSize(context)) / 2 - 4),
            prefixIcon: widget.isPassword ? const Icon(FontAwesomeIcons.key) : const Icon(FontAwesomeIcons.at),
            suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ) : null,
          ),
        ),
      ),
    );
  }
}
