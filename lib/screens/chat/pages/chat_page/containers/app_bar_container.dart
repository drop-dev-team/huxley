import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String chatPhotoURL;
  final String chatTitle;

  const ChatAppBar({super.key, required this.chatPhotoURL, required this.chatTitle});

  @override
  Size get preferredSize => const Size.fromHeight(56); // Standard AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1), // Use theme color with transparency
      elevation: 0, // No shadow
      titleSpacing: 0, // No extra spacing at the start
      title: _buildTitleSection(context),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1), // Slight white tint for visibility
      padding: const EdgeInsets.symmetric(horizontal: 16), // Standard horizontal padding
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10), // Standard space after back button
          _buildAvatar(chatPhotoURL),
          const SizedBox(width: 10), // Space between avatar and title
          _buildTitle(context, chatTitle),
          const Spacer(), // Pushes the settings icon to the far right
          _buildSettingsButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 16, // Appropriately sized radius for app bars
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black, // Use primary color from theme
        fontSize: 20, // Appropriate font size for titles
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      color: Theme.of(context).iconTheme.color, // Use icon theme color
      onPressed: () {
        // Define your settings action here
      },
      tooltip: 'Settings', // Tooltip for accessibility
    );
  }
}
