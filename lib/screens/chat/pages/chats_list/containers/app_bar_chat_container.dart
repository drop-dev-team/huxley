import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => {
                    print("Navigate to add user window")
                  },
                  icon: const Icon(
                      FontAwesomeIcons.userPlus,
                    color: Colors.blueAccent,
                  )
              ),
              const Spacer(),
              const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://solairconference.com/data/files/big-brain.png"
                  ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Ask Huxley',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                onPressed: () {
                  print('Icon pressed');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
