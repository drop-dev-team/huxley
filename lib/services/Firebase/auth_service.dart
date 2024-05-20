import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Singleton pattern setup: private constructor and static final instance
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  var verificationID = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  // Email & Password Sign Up
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Email & Password Sign In
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Phone Number Sign In
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
  
  
  Future<bool> verifyOTP(String otp) async{
    return (await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationID.value,
            smsCode: otp)
    ) != null ? true : false);
  }
}
