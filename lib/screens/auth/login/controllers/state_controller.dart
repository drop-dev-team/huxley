import 'package:get/get.dart';

class StateController extends GetxController {
  RxBool isEmail = false.obs;

  void toggle() {
    isEmail.value = !isEmail.value;
  }
}
