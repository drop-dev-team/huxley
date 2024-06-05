import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/information_input_controller.dart';

class DisplayNameEntry extends StatefulWidget {
  const DisplayNameEntry({super.key});

  @override
  State<DisplayNameEntry> createState() => _DisplayNameEntryState();
}

class _DisplayNameEntryState extends State<DisplayNameEntry> {
  late final TextEditingController _usernameController;
  late final InformationInputController infoController;
  final Duration _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    infoController = Get.find<InformationInputController>(); // Get the instance from GetX
    _usernameController = infoController.displayNameController; // Assign the controller
    _usernameController.addListener(infoController.validateUsername); // Add listener to validate username
  }

  @override
  void dispose() {
    _usernameController.removeListener(infoController.validateUsername); // Remove listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 150,
              backgroundImage: NetworkImage('https://cdn.dribbble.com/users/1537480/screenshots/7176229/media/11d782940ea0293d3d7f7c8d9b040a18.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Set your Display Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your display name will be used in chat functionalities and will be visible to other users. Please choose a name you are comfortable sharing and identifies you the most!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(width: 2, color: Colors.blueAccent),
                ),
                prefixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                suffixIcon: Obx(() => AnimatedSwitcher(
                  duration: _animationDuration,
                  child: ClipOval(
                    key: ValueKey(infoController.isUsernameValid.value),
                    child: Container(
                      color: infoController.isUsernameValid.value ? Colors.green : Colors.red,
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        infoController.isUsernameValid.value ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                )),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
                  () => infoController.isUsernameValid.value
                  ? const Text('Saved! Continue Above ... 🥳',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.blue))
                  : const Text(
                "That doesn't look quite right...🤔",
                style: TextStyle(
                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
