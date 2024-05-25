import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../services/Firebase/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService.instance;

  var isUserLoggedIn = false.obs;
  var isLoading = false.obs;
  var user = Rxn<User>();
  var verificationID = ''.obs;

  AuthService instance = AuthService.instance;

  @override
  void onInit() {
    super.onInit();

    _authService.auth.authStateChanges().listen((User? user) {
      if (user != null) {
        this.user.value = user;
        isUserLoggedIn(true);
      } else {
        isUserLoggedIn(false);
      }
    });
  }

  void signInWithGoogle(
      {required VoidCallback onSuccess,
      required VoidCallback onError,
      required BuildContext context}) async {
    isLoading(true);
    try {
      user.value = await _authService.signInWithGoogle();
      if (user.value != null) {
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
    user.value = await _authService.signUpWithEmailAndPassword(email, password);
    isLoading(false);
  }

  void signInWithEmailAndPassword(String email, String password) async {
    isLoading(true);
    user.value = await _authService.signInWithEmailAndPassword(email, password);
    isLoading(false);
  }

  void signInWithPhoneNumber(String phoneNumber) async {
    isLoading(true);
    await _authService.signInWithPhoneNumber(phoneNumber);
    isLoading(false);
  }

  void verifyOTP(String otp) async {
    isLoading(true);
    if (await _authService.verifyOTP(otp)) {
      Get.snackbar("Success", "You are successfully logged in!");
    } else {
      Get.snackbar(
          "Verification Failed", "Invalid OTP entered, please try again.");
    }
    isLoading(false);
  }

  void logout() async {
    isLoading(true);
    await _authService.auth.signOut();
    user.value = null;
    isLoading(false);
  }
}
