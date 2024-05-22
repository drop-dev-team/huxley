// auth_controller.dart
import 'package:get/get.dart';

class StateController extends GetxController {
  RxBool isEmail = false.obs;  // Observable for toggling between email and phone

  void toggle() {
    isEmail.value = !isEmail.value;  // Toggle the value
  }
}
