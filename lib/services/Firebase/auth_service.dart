import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database_service.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();
  var verificationID = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get auth => _auth;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationID, resendToken) {
        this.verificationID.value = verificationID;
      },
      codeAutoRetrievalTimeout: (verificationID) {
        this.verificationID.value = verificationID;
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (verificationFailedException) {
        if (verificationFailedException.code == 'invalid-phone-number') {
          Get.snackbar("Hummm that's sus", "The provided number is not valid");
        } else {
          Get.snackbar("Error...", "Something went wrong Try again...");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    return (await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationID.value, smsCode: otp)) != null
        ? true
        : false
    );
  }



  Future<void> updateEmail(String email) async {
    User? user = _auth.currentUser;
    await user?.verifyBeforeUpdateEmail(email);
  }

  // Update user's password
  Future<void> updatePassword(String password) async {
    User? user = _auth.currentUser;
    await user?.updatePassword(password);
  }

  // Update user's phone number
  Future<void> updatePhoneNumber(String phoneNumber) async {
    User? user = _auth.currentUser;
    // Assuming phoneNumber is verified and formatted properly
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: '', smsCode: '');
    await user?.updatePhoneNumber(credential);
  }

  // Update user's photo URL after uploading the file
  Future<String> updatePhotoURL(File photo) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    // Upload the file and get the URL
    String photoUrl = await DatabaseService.instance.uploadFile(photo);
    // Update the user's photo URL in the authentication service
    await user.updatePhotoURL(photoUrl);
    // Return the URL for further use
    return photoUrl;
  }


  Future<void> updateDisplayname(String displayname) async {
    User? user = _auth.currentUser;
    await user?.updateDisplayName(displayname);
  }
}
