// auth_controller.dart
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isEmail = true.obs;  // Observable for toggling between email and phone

  void toggle() {
    isEmail.value = !isEmail.value;  // Toggle the value
  }
}
