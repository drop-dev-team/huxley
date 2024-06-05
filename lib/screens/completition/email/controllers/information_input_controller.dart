import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationInputController extends GetxController {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  Rx<File?> profileImage = Rx<File?>(null);  // Initially, no image is selected
  RxBool isUsernameValid = false.obs;

  bool get isDisplayNameFilled => displayNameController.text.trim().isNotEmpty;
  bool get isProfilePictureAdded => profileImage.value != null;
  bool get isPhoneNumberFilled => phoneNumberController.text.trim().isNotEmpty;

  // Checks if all fields meet the conditions for submission
  bool get canSubmit {
    return isDisplayNameFilled && isPhoneNumberFilled && profileImage.value != null;
  }

  void validateUsername() {
    // Check if the text is not empty and at least 4 characters long
    bool isValid = displayNameController.text.isNotEmpty && displayNameController.text.length >= 4;
    isUsernameValid.value = isValid;  // Update the reactive state
  }

  void updateDisplayName(String displayName) {
    displayNameController.text = displayName;
  }

  // Method to update the image
  void updateImage(File? newImage) {
    profileImage.value = newImage;
  }

  // Call this method when the submit button is pressed todo
  void submitData() {
    if (canSubmit) {
      // Here you would typically send data to a server or next page in your application
      print('Submitting Data...');
      print('Name: ${displayNameController.text}');
      print('Phone: ${phoneNumberController.text}');
      print('Image Path: ${profileImage.value?.path}');
    } else {
      // Handle what happens if data cannot be submitted (e.g., show an error message)
      print('Cannot submit data. Please check the input fields.');
    }
  }

  @override
  void onClose() {
    // Clean up the controller when the widget is disposed.
    displayNameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
