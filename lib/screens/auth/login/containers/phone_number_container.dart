import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';
import 'package:flutter/services.dart';

class PhoneNumberInputContainer extends StatefulWidget {
  final TextEditingController controller;
  final Function(bool)? onValidityChanged;

  const PhoneNumberInputContainer({super.key, required this.controller, this.onValidityChanged, });

  @override
  State<PhoneNumberInputContainer> createState() => _PhoneNumberInputContainerState();
}

class _PhoneNumberInputContainerState extends State<PhoneNumberInputContainer> {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePhoneNumber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size fieldSize = _responsiveSizer.phoneNumberInputDimensions(context);

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
                vertical: (fieldSize.height - _responsiveSizer.textSize(context)) / 2 - 4,
                horizontal: 20),
          ),
          initialCountryCode: Platform.localeName.split('_')[1],
          onChanged: (phone) {
            widget.controller.text = phone.completeNumber;
            _validatePhoneNumber();
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
        ),
      ),
    );
  }

  void _validatePhoneNumber() {
    // Remove all non-digit characters from the input to simplify extraction
    String input = widget.controller.text.replaceAll(RegExp(r'\D'), '');
    // Extract the last 10 digits assuming these include the area code and the main number
    String lastTenDigits = input.length >= 10 ? input.substring(input.length - 10) : '';

    // Check if we have exactly 10 digits
    final regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    bool isValid = regex.hasMatch(lastTenDigits);


    if (isValid != _isValid) {
      setState(() {
        _isValid = isValid;
      });
      widget.onValidityChanged?.call(_isValid);  // Notify the parent widget if there's a change
    }
  }



}
