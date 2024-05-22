import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

class ContinueButtonWidget extends StatelessWidget {

  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  ContinueButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          print("Continue button");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: _responsiveSizer.buttonDimensions(context),
            maximumSize: _responsiveSizer.buttonDimensions(context)
        ),
        child: Text(
          AppLocalizations.of(context)!.continueText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14, // Adjusted for smaller button size
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
