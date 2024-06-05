import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../blueprint/profile_completition_screen_blueprint.dart';
import '../controllers/information_input_controller.dart';

class ProfileCompletionScreen extends StatefulWidget {
  final InformationInputController informationInputController = Get.put(InformationInputController());

  ProfileCompletionScreen({super.key});

  @override
  State<ProfileCompletionScreen> createState() => _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProfileCompletionScreenBlueprint(),
      ),
    );
  }
}
