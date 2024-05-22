import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

import '../controllers/state_controller.dart';

class ToggleButton extends StatefulWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  late Size size; // Custom size for the toggle button

  ToggleButton({Key? key,}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final StateController controller = Get.find<StateController>();
  double xPosition = 0; // Initial position of the draggable button

  @override
  void initState() {
    super.initState();
    // Initialize position based on the controller's initial value
    updateXPosition();
  }

  void updateXPosition() {
    // Calculate xPosition based on isEmail value
    xPosition = controller.isEmail.value ? -0.3 : 0.3;
  }

  @override
  Widget build(BuildContext context) {
    widget.size = widget._responsiveSizer.sliderButtonDimensions(context);
    return GestureDetector(
      onTap: () {
        controller.isEmail.toggle();
        setState(updateXPosition);
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          xPosition += details.primaryDelta! / (context.size!.width / 2);
          // Clamp the xPosition to avoid dragging out of bounds
          xPosition = xPosition.clamp(-0.3, 0.3);
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
                width: widget.size.width,  // Use custom width from Size
                height: widget.size.height,  // Use custom height from Size
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
