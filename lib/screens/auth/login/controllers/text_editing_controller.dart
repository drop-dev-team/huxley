import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controllers/screen_state_controller.dart';

class TextEditingWidgetController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  TextEditingController? confirmPasswordController;
  late TextEditingController phoneNumberController;

  // Reference to the screen state controller
  final ScreenStateController screenStateController = Get.find();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();

    // Listen to changes in screen state to create or dispose controllers as necessary
    ever(screenStateController.isSignUp, handleSignUpChange);
  }

  void handleSignUpChange(bool isSignUp) {
    if (isSignUp) {
      // If it's a sign-up screen, initialize the confirm password controller
      confirmPasswordController ??= TextEditingController();
    } else {
      // Dispose of the confirm password controller when switching to login
      confirmPasswordController?.dispose();
      confirmPasswordController = null;
    }
  }

  @override
  void onClose() {
    // Dispose of all controllers
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController
        .dispose(); // Ensure phoneNumberController is also disposed
    confirmPasswordController?.dispose();
    super.onClose();
  }

  bool isSignUpEqualsPasswordConfirm() {
    return screenStateController.isSignUp.value ? (
        passwordController.text == confirmPasswordController?.text
    ) : (
        false
    );
  }
}
