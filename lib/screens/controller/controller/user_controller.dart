import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isUserLoggedIn = false.obs;
  var user = Rxn<User>();  // Firebase Auth User

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Attach a listener to FirebaseAuth instance to handle real-time auth changes
    _auth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        user.value = firebaseUser;  // Update the observed user
        isUserLoggedIn(true);
      } else {
        user.value = null;
        isUserLoggedIn(false);
      }
    });
  }

  // Function to handle logout
  void logout() async {
    await _auth.signOut();
    isUserLoggedIn(false);
    user.value = null; // Clear user data
  }
}
