import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rxn<User> user = Rxn<User>();  // Firebase Auth User, reactive nullable
  var isUserLoggedIn = false.obs;  // Observable for user login status

  final FirebaseAuth _auth = FirebaseAuth.instance;  // Firebase Auth instance

  @override
  void onInit() {
    super.onInit();
    // Attach a listener to FirebaseAuth instance to handle real-time auth changes
    _auth.authStateChanges().listen(_userChanged);
  }

  // Handle user state changes
  void _userChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      user.value = firebaseUser;  // Update the observed user
      isUserLoggedIn(true);  // Set user logged in to true
    } else {
      user.value = null;  // Clear user value
      isUserLoggedIn(false);  // Set user logged in to false
    }
  }

  // Function to handle logout
  void logout() async {
    try {
      await _auth.signOut();
      isUserLoggedIn(false);
      user.value = null;  // Clear user data
    } catch (e) {
      Get.snackbar('Logout Error', 'Failed to log out: ${e.toString()}');
    }
  }
}
