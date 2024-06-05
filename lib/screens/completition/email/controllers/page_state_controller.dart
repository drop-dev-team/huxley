import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controllers/auth_controller.dart';
import '../../../controller/menu/navigation_menu.dart';
import '../checkers/user_state_checker.dart';
import 'information_input_controller.dart';

class ProfileCompletionController extends GetxController {
  final InformationInputController infoController = Get.find<InformationInputController>();
  final AuthController _authController = Get.find<AuthController>();

  var currentNode = 1.obs;

  @override
  void onInit() {
    super.onInit();
    currentNode.value = 0;
    updateNodeIndex();
  }

  int get totalSteps => 3;

  void updateNodeIndex() {
    int index = 0;
    if (infoController.isDisplayNameFilled) index++;
    if (infoController.profileImage.value != null) index++;
    if (infoController.isPhoneNumberFilled) index++;

    currentNode.value = index.clamp(1, totalSteps);
  }

  void nextStep() {
    if (currentNode.value == 1 && !infoController.isDisplayNameFilled) {
      _showErrorSnackBar("Please provide a username to proceed.");
    } else {
      if (currentNode.value < totalSteps) {
        currentNode.value++;
      }
    }
  }

  void previousStep() {
    if (currentNode.value > 1) {
      currentNode.value--;
    } else {
      // If we're at the first step and user presses back, navigate to the previous screen
      Get.back();
    }
  }

  Future<void> triggerTransition(BuildContext context) async {
    if (!context.mounted) return;

    // Await each operation that involves asynchronous tasks
    await _authController.updateDisplaynameSafe(infoController.displayNameController.text);
    await _updateProfilePicture();
    await _updatePhoneNumber();

    // Depending on what `navigateOnFieldsFilled` does, you might need to handle it differently
    // If it's just checking conditions and navigating without async operations, it can be called directly
    Get.offAll(() => const NavigationMenu());
  }


  Future<void> _updateProfilePicture() async{
    File? userProfilePictureFile = infoController.profileImage.value;
    if (userProfilePictureFile != null) {
      _authController.updatePhotoURLSafe(userProfilePictureFile);
    }
  }

  Future<void> _updatePhoneNumber() async {
    String phoneNumber = infoController.phoneNumberController.text;
    if (phoneNumber.isNotEmpty) {
      _authController.updatePhoneNumberSafe(phoneNumber);
    }
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar(
      "Missing Information",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
