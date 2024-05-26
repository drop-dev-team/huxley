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

  AuthService instance = AuthService.instance;
  @override
  void onInit() {
    super.onInit();
    // Listen to changes in the authentication state
    _authService.auth.authStateChanges().listen((User? user) {
      this.user.value = user;
      isUserLoggedIn(user != null); // Update login status based on user presence
    });
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

  void signUpWithEmailAndPassword(String email, String password) async {
    isLoading(true);
    try {
      User? result = await _authService.signUpWithEmailAndPassword(email, password);
      user.value = result;
    } catch (e) {
      Get.snackbar("Signup Error", "Failed to sign up: $e");
    } finally {
      isLoading(false);
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    isLoading(true);
    try {
      User? result = await _authService.signInWithEmailAndPassword(email, password);
      user.value = result;
    } catch (e) {
      Get.snackbar("Sign In Error", "Failed to sign in: $e");
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
}
