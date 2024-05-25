import 'package:flutter/material.dart';

import '../constants/auth_constants.dart';

class ImageLogoWidget extends StatelessWidget {
  const ImageLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(AuthConstants.logoURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
