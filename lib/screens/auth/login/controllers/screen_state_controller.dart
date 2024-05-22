import 'package:get/get.dart';

class ScreenStateController extends GetxController {
  var isSignUp = false.obs;

  void toggleSignUp() {
    isSignUp.value = !isSignUp.value;
  }
}
