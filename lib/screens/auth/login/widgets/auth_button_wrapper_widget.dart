import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../dynamic/layout/responsive_sizer.dart';

class AuthButtonWrapperWidget extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  final VoidCallback onPressed;
  final Widget icon;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;

  AuthButtonWrapperWidget({
    super.key,
    required this.onPressed,
    required this.icon, // This can now be an Icon or an Image widget
    required this.buttonText,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    Size buttonSize = _responsiveSizer.authButtonDimensions(context);
    double fontSize = _responsiveSizer.textSize(context);

    return Center( // Centers the container to prevent stretching
      child: SizedBox(
        width: buttonSize.width,
        height: buttonSize.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.zero, // No internal padding to control size via Container
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: _responsiveSizer.spacingSize(context)), // Spacing based on responsive sizer
              Text(
                buttonText,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize, // Text size based on responsive sizer
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
