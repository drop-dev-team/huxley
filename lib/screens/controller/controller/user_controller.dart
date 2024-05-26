import 'package:get/get.dart';
import '../../auth/login/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  Rxn<User> user = Rxn<User>(); // Observable user
  var isUserLoggedIn = false.obs; // Observable login status

  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    // Bind to the AuthController's user observable
    _authController.user.bindStream(_authController.instance.auth.authStateChanges());
    ever(_authController.user, handleAuthChange);  // Listen to changes in the AuthController's user
  }

  void handleAuthChange(User? firebaseUser) {
    user.value = firebaseUser; // Update the local user observable
    isUserLoggedIn(firebaseUser != null); // Update login status based on presence of user
  }

  void logout() async {
    _authController.logout(); // Delegate logout action to AuthController
  }
}
