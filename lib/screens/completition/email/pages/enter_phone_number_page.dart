import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/login/containers/phone_number_container.dart';
import '../controllers/information_input_controller.dart';
import 'is_user_complete.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final InformationInputController infoController = Get.find<InformationInputController>();
  late TextEditingController _phoneController;
  bool _isPhoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController = infoController.phoneNumberController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Phone Number"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100, // Size of the avatar, adjust as necessary
                backgroundImage: NetworkImage('https://cdn.dribbble.com/users/517682/screenshots/16524868/media/9fca31b04190592771c4aa724a220ff5.png?resize=1200x900&vertical=center'), // Your image link here
                backgroundColor: Colors.transparent, // Optional: Makes the background transparent
              ),
              const SizedBox(height: 100,),
              PhoneNumberInputContainer(
                controller: _phoneController,
                onValidityChanged: (bool isValid) {
                  setState(() {
                    _isPhoneNumberValid = isValid;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isPhoneNumberValid ? _submitButton : null,  // Ensure this is correctly named
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.blue.withOpacity(0.5).withOpacity(0.38), disabledBackgroundColor: Colors.blue.withOpacity(0.5).withOpacity(0.12),  // Background color when disabled
                  textStyle: const TextStyle(fontSize: 16),  // Text style
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),  // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),  // Rounded corners
                  ),
                  elevation: 10,  // Shadow elevation when button is enabled// No shadow when button is disabled
                ),
                child: const Text("Continue"),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _submitButton() {
    // here we navigate to the process the information and navigate to the next screen
    Get.offAll(const UserCompletePage());
  }
}
