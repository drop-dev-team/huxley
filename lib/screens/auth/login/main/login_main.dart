import 'package:flutter/material.dart';
import 'package:huxley/screens/auth/login/blueprint/login_screen_blueprint.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LogInScreenBluePrint(),
      ),
    );
  }
}
