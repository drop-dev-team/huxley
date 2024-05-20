import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/state_controller.dart';

class ToggleButton extends StatefulWidget {
  ToggleButton({Key? key}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final AuthController controller = Get.find<AuthController>();
  double xPosition = 0; // Initial position of the draggable button

  @override
  void initState() {
    super.initState();
    // Initialize position based on the controller's initial value
    updateXPosition();
  }

  void updateXPosition() {
    // Calculate xPosition based on isEmail value
    xPosition = controller.isEmail.value ? -0.3 : 0.4;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.isEmail.toggle();
        setState(updateXPosition);
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          xPosition += details.primaryDelta! / (context.size!.width / 2);
          // Clamp the xPosition to avoid dragging out of bounds
          xPosition = xPosition.clamp(-0.3, 0.4);
        });
      },
      onHorizontalDragEnd: (details) {
        // Determine the position to snap based on the drag's end
        bool shouldSnapToEmail = xPosition < 0.05;
        if (controller.isEmail.value != shouldSnapToEmail) {
          controller.isEmail.value = shouldSnapToEmail;
        }
        setState(updateXPosition);
      },
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xPosition, 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 90,  // Width of the inner sliding button
              height: 34,  // Height of the inner sliding button
              decoration: BoxDecoration(
                color: controller.isEmail.value ? Colors.blue : Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: controller.isEmail.value ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Icon(controller.isEmail.value ? FontAwesomeIcons.angleRight : FontAwesomeIcons.angleLeft, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    controller.isEmail.value ? 'Email' : 'Phone',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
