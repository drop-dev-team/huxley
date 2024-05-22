import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';
import 'package:flutter/services.dart'; // Import services for TextInputFormatter

class PhoneNumberInputContainer extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer =
      ResponsiveSizer(); // Instance of ResponsiveSizer

  PhoneNumberInputContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the dimensions for the input field from ResponsiveSizer
    Size fieldSize = _responsiveSizer.phoneNumberInputDimensions(
        context); // Assume this method exists in your ResponsiveSizer

    return Center(
      child: SizedBox(
        width: fieldSize.width,
        height: fieldSize.height,
        child: IntlPhoneField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.enterPhoneFieldText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(
                vertical:
                    (fieldSize.height - _responsiveSizer.textSize(context)) /
                            2 -
                        4,
                horizontal: 20),
          ),
          initialCountryCode: Platform.localeName.split('_')[1],
          onChanged: (phone) {
            print(phone.completeNumber);
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20), // Allows for up to 20 digits
          ],
        ),
      ),
    );
  }
}
