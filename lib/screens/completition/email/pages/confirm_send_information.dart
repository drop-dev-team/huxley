import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'is_user_complete.dart';

class ConfirmSendInformationPage extends StatelessWidget {
  const ConfirmSendInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Add padding around the entire page content
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const NetworkImage('https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmJqOGkzOTJvZ3JkcW1qNXd4dmxka3hmYTFweW1oN3UyNWV0ZDgzYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ibolLe3mOqHE3PQTtk/giphy.webp'),
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "By continuing, we will update your profile on our end. This information will be editable, so don't hesitate to submit!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Implement the submit functionality
                      Get.offAll(const UserCompletePage());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
