import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flexible(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image.network(
            'https://shop.raceya.fit/wp-content/uploads/2020/11/logo-placeholder.jpg',
            fit: BoxFit.fill,
            width: 300,
            height: 350,
          ), // Ensure the logo asset is in the assets folder
        ),
      ),
    );
  }
}
