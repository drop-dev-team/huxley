import 'package:flutter/material.dart';

class UserProfileItem extends StatelessWidget {
  final String? profilePictureURL;
  final bool isActive;
  final String username; // Username to display below the picture

  const UserProfileItem({
    super.key,
    this.profilePictureURL,
    required this.isActive,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4), // Ensure there's some padding
      width: 100, // Adjust the width to fit your design
      child: InkWell(
        onTap: () => {// todo Navigate to chat Screen
          print("Tapped on card ${username}")
          },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50, // Match the width to maintain aspect ratio
              height: 50, // Keep this the same as width for a circle
              child: Stack(
                children: [
                  // Profile Picture
                  Positioned.fill(
                    child: ClipOval(
                      child: profilePictureURL != null
                          ? Image.network(
                        profilePictureURL!,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/default_profile_pic.png', // Default image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Status Indicator
                  Positioned(
                    right:1,
                    bottom: 1,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, // Contrast border
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4), // Space between picture and text
            Text(
              username,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
              maxLines: 1, // Ensures the text is only one line
            ),
          ],
        ),
      ),
    );
  }
}
