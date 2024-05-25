import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controllers/screen_state_controller.dart';

class TextEditingWidgetController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  TextEditingController? confirmPasswordController;
  late TextEditingController phoneNumberController;

  final ScreenStateController screenStateController = Get.find();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();

    ever(screenStateController.isSignUp, handleSignUpChange);
  }

  void handleSignUpChange(bool isSignUp) {
    if (isSignUp) {
      confirmPasswordController ??= TextEditingController();
    } else {
      confirmPasswordController?.dispose();
      confirmPasswordController = null;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController?.dispose();
    super.onClose();
  }

  bool isSignUpEqualsPasswordConfirm() {
    return screenStateController.isSignUp.value
        ? (passwordController.text == confirmPasswordController?.text)
        : (false);
  }
}
