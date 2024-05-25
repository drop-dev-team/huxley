import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:huxley/dynamic/layout/responsive_sizer.dart';

import '../controllers/state_controller.dart';

class ToggleButton extends StatefulWidget {
  final ResponsiveSizer _responsiveSizer = ResponsiveSizer();
  late Size size;

  ToggleButton({super.key,});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final StateController controller = Get.find<StateController>();
  double xPosition = 0; 

  @override
  void initState() {
    super.initState();
    
    updateXPosition();
  }

  void updateXPosition() {
    
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
          
          xPosition = xPosition.clamp(-0.3, 0.3);
        });
      },
      onHorizontalDragEnd: (details) {
        
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
                width: widget.size.width,  
                height: widget.size.height,  
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
