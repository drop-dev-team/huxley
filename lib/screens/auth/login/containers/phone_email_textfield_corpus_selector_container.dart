import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';
import 'package:huxley/screens/auth/login/containers/phone_number_container.dart';
import '../controllers/screen_state_controller.dart';
import '../controllers/state_controller.dart';
import '../controllers/text_editing_controller.dart';
import '../widgets/input_text_field_widget.dart';
import '../widgets/toggle_slider_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputFieldWrapper extends StatelessWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  final StateController controller = Get.find<StateController>();
  final ScreenStateController screenController =
      Get.find<ScreenStateController>();
  final TextEditingWidgetController textController =
      Get.put(TextEditingWidgetController());

  InputFieldWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleButton(),
              SizedBox(height: _responsiveSizer.spacingSize(context)),
              Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.isEmail.value
                        ? emailFields(context)
                        : phoneField(context),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailFields(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputTextFieldWidget(
              hintText: AppLocalizations.of(context)!.enterEmailFieldText,
              controller: textController.emailController,
              isPassword: false,
            ),
            SizedBox(height: _responsiveSizer.spacingSize(context)),
            InputTextFieldWidget(
              hintText: AppLocalizations.of(context)!.enterPasswordFieldText,
              controller: textController.passwordController,
              isPassword: true,
            ),
            Column(
              children: [
                SizedBox(height: _responsiveSizer.spacingSize(context)),
                if (screenController.isSignUp.isTrue)
                  InputTextFieldWidget(
                    hintText:
                        AppLocalizations.of(context)!.confirmPasswordFieldText,
                    controller: textController.confirmPasswordController ??
                        TextEditingController(),
                    isPassword: true,
                  ),
              ],
            ),
          ],
        ));
  }

  Widget phoneField(BuildContext context) {
    var textController = Get.find<TextEditingWidgetController>();

    if (_responsiveSizer.getCurrentPlatform(context) == 'Mobile' ||
        _responsiveSizer.getCurrentPlatform(context) == 'Tablet') {
      return PhoneNumberInputContainer();
    } else {
      return InputTextFieldWidget(
        hintText: AppLocalizations.of(context)!.enterPhoneFieldText,
        isPassword: false,
        controller: textController.phoneNumberController,
      );
    }
  }
}
