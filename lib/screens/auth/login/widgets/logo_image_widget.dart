import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Image.asset(
            'assets/logo.png'), // Ensure the logo asset is in the assets folder
      ),
    );
  }
}
