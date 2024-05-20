import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';
import '../controller/state_controller.dart';
import '../widgets/input_text_field_widget.dart';
import '../widgets/toggle_slider_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputFieldWrapper extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  final AuthController controller = Get.find<AuthController>();

  InputFieldWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButton(),
        SizedBox(height: _responsiveSizer.spacingSize(context)),
        Obx(() {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.fastEaseInToSlowEaseOut,
            switchOutCurve: Curves.fastEaseInToSlowEaseOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            child: controller.isEmail.value
                ? emailFields(context)
                : phoneField(context),
          );
        }),
      ],
    );
  }

  Widget emailFields(BuildContext context) {
    return Container(
      key: const ValueKey('emailFields'),
      child: Column(
        children: [
          InputTextFieldWidget(
              hintText: AppLocalizations.of(context)!.enterEmailFieldText),
          SizedBox(height: _responsiveSizer.spacingSize(context)),
          InputTextFieldWidget(
              hintText: AppLocalizations.of(context)!.enterPasswordFieldText),
        ],
      ),
    );
  }

  Widget phoneField(BuildContext context) {
    return Container(
      key: const ValueKey('phoneField'),
      child: InputTextFieldWidget(
          hintText: AppLocalizations.of(context)!.enterPhoneFieldText
      ),
    );
  }
}
