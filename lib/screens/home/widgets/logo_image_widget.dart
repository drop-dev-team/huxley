import 'package:flutter/material.dart';

import '../constants/home_screen_constants.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      HomeScreenConstants.placeHolderLogo,
      height: 350, // Adjust as needed
      alignment: Alignment.center,
    );
  }
}
