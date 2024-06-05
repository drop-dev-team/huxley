import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../services/Firebase/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService.instance;

  var isUserLoggedIn = false.obs; // Observable to track login status
  var isLoading = false.obs; // Observable to track loading status
  Rxn<User> user = Rxn<User>(); // Reactive nullable Firebase user
  var verificationID = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to changes in the authentication state
    _authService.auth.authStateChanges().listen((User? user) {
      this.user.value = user;
      isUserLoggedIn(user != null); // Update login status based on user presence
    });
  }

  Stream<User?> authStateChanges() {
    return _authService.auth.authStateChanges();
  }

  void signInWithGoogle({
    required VoidCallback onSuccess,
    required VoidCallback onError,
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      User? result = await _authService.signInWithGoogle();
      user.value = result;
      if (result != null) {
        onSuccess();
      } else {
        onError();
      }
    } catch (e) {
      onError();
      if (!context.mounted) return;
      Get.snackbar(
        AppLocalizations.of(context)!.googleOnErrorAuth,
        AppLocalizations.of(context)!.googleOnErrorAuthText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void signUpWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError,
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      User? result = await _authService.signUpWithEmailAndPassword(email, password);
      if (result != null) {
        user.value = result;
        onSuccess();
      } else {
        onError();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        onError();
        if (!context.mounted) return;
        onError();
      } else {
        onError();
        if (!context.mounted) return;
        Get.snackbar(
          "Signup Error",
          "Failed to sign up: ${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      onError();
      if (!context.mounted) return;
      Get.snackbar(
        "Signup Error",
        "Failed to sign up: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }


  void signInWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError,
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      User? result = await _authService.signInWithEmailAndPassword(email, password);
      if (result != null) {
        user.value = result;
        onSuccess();
      } else {
        onError();
      }
    } on FirebaseAuthException catch (e) {
      onError();
      if (!context.mounted) return;
      Get.snackbar(
        "Sign In Error",
        "Failed to sign in: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      onError();
      if (!context.mounted) return;
      Get.snackbar(
        "Sign In Error",
        "Failed to sign in: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }


  void signInWithPhoneNumber(String phoneNumber) async {
    isLoading(true);
    try {
      await _authService.signInWithPhoneNumber(phoneNumber);
    } catch (e) {
      Get.snackbar("Phone Sign In Error", "Failed to sign in with phone: $e");
    } finally {
      isLoading(false);
    }
  }

  void verifyOTP(String otp) async {
    isLoading(true);
    try {
      bool result = await _authService.verifyOTP(otp);
      if (result) {
        Get.snackbar("Success", "You are successfully logged in!");
      } else {
        Get.snackbar("Verification Failed", "Invalid OTP entered, please try again.");
      }
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    isLoading(true);
    try {
      await _authService.auth.signOut();
      user.value = null; // Clear the user
      isUserLoggedIn(false); // Update login status
    } catch (e) {
      Get.snackbar("Logout Error", "Failed to log out: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateDisplaynameSafe(String displayname) async {
    try {
      await _authService.updateDisplayname(displayname);
      Get.snackbar("Success", "Display name updated successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to update display name: $e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void updateEmailSafe(String email) async {
    try {
      await _authService.updateEmail(email);
      Get.snackbar("Success", "Email updated successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to update email: $e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Safely update user's password and show feedback
  void updatePasswordSafe(String password) async {
    try {
      await _authService.updatePassword(password);
      Get.snackbar("Success", "Password updated successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to update password: $e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Safely update user's phone number and show feedback
  void updatePhoneNumberSafe(String phoneNumber) async {
    try {
      await _authService.updatePhoneNumber(phoneNumber);
      Get.snackbar("Success", "Phone number updated successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to update phone number: $e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Safely update user's photo URL after uploading the photo and show feedback
  Future<String> updatePhotoURLSafe(File photo) async {
    try {
      // Assuming _authService.updatePhotoURL now returns the URL of the uploaded photo
      String photoUrl = await _authService.updatePhotoURL(photo);
      Get.snackbar("Success", "Photo updated successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      return photoUrl; // Return the URL on success
    } catch (e) {
      Get.snackbar("Error", "Failed to update photo: $e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return Future.error("Failed to update photo: $e"); // Return an error
    }
  }

}
