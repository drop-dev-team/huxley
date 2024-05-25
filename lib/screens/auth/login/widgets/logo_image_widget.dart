import 'package:flutter/material.dart';

import '../../../home/constants/home_screen_constants.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flexible(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image.network(
            HomeScreenConstants.placeHolderLogo,
            fit: BoxFit.fill,
          ), // Ensure the logo asset is in the assets folder
        ),
      ),
    );
  }
}
