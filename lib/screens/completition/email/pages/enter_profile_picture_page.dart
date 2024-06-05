import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../controllers/information_input_controller.dart';

class ProfilePictureEntry extends StatefulWidget {
  const ProfilePictureEntry({super.key});

  @override
  State<ProfilePictureEntry> createState() => _ProfilePictureEntryState();
}

class _ProfilePictureEntryState extends State<ProfilePictureEntry> {
  final InformationInputController infoController = Get.find<InformationInputController>();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        infoController.updateImage(imageFile); // Update image in the controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: Obx(() => infoController.profileImage.value != null
                  ? Image.file(infoController.profileImage.value!, fit: BoxFit.cover)
                  : const Center(child: Text('No image selected', style: TextStyle(color: Colors.black54)))
              ),
            ),
          ),
        ),
        const Text('Set your Profile Picture!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('This is for giving identity to you. Choose what represents you the most! Or you can Skip this step by pressing the arrows above!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey)
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Select Image'),
        ),
      ],
    );
  }
}
