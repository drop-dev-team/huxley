import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/page_state_controller.dart';
import '../pages/confirm_send_information.dart';
import '../pages/enter_display_name_page.dart';
import '../pages/enter_profile_picture_page.dart';
import '../widgets/containers/card_progress_container.dart';

class ProfileCompletionScreenBlueprint extends StatefulWidget {
  final ProfileCompletionController _completionController =
  Get.find<ProfileCompletionController>();

  ProfileCompletionScreenBlueprint({super.key});

  @override
  State<ProfileCompletionScreenBlueprint> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState
    extends State<ProfileCompletionScreenBlueprint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget._completionController.currentNode.value > 0
              ? widget._completionController.previousStep
              : null,  // Only enable the back button if it's not the first step
        ),
        title: const Text('Profile Completion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: widget._completionController.currentNode.value < widget._completionController.totalSteps
                ? widget._completionController.nextStep
                : null,  // Only enable the forward button if it's not the last step
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => CardProgressContainer(
              numberOfSteps: 3,
              nodeSize: 40,
              currentNode: widget._completionController.currentNode.value,
            )),
            const SizedBox(height: 20), // Optional spacing
            Expanded(
              child: Obx(() => _getPageContent(widget._completionController.currentNode.value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageContent(int page) {
    switch (page) {
      case 1:
        return const DisplayNameEntry();
      case 2:
        return const ProfilePictureEntry();
      case 3:
        return const ConfirmSendInformationPage();
      default:
        return Center(
          child: Text(
            "Step $page Content",
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }
}
