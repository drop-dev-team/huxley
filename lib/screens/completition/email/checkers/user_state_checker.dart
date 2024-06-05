import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/controller/controller/user_controller.dart';
import '../../../controller/menu/navigation_menu.dart';
import '../main/completition_screen.dart';

class UserStateChecker {
  /*
  This class checks if the user has all necessary fields filled. If certain required fields are missing,
  the user is directed to stay on the splash screen to provide this information. Fields include:
    - Required: displayName (must not be null for chat functionality)
    - Optional: photoURL (used for identification, should be prompted but not enforced)
    - Optional: phoneNumber (can be left blank, but prompted if not provided)
  */

  final UserController _userController = Get.find<UserController>();

  bool userHasDisplayName() {
    return _userController.user.value?.displayName != null;
  }

  bool userHasPictureURL() {
    return _userController.user.value?.photoURL != null;
  }

  bool userHasPhoneNumber() {
    return _userController.user.value?.phoneNumber != null;
  }

  bool userIsReady() {
    return userHasDisplayName();
  }

  void navigateOnFieldsFilled(BuildContext context) {
    if (!context.mounted) return;

    bool shouldNavigate = userHasDisplayName();
    bool optionalFieldsNeeded = !userHasPhoneNumber();

    if (shouldNavigate) {
      if (optionalFieldsNeeded) {
      }
      Get.offAll(() => const NavigationMenu());
    } else {

      Get.offAll(() => ProfileCompletionScreen());
    }
  }
}
