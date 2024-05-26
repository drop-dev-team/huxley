import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:huxley/screens/home/container/user_circular_avatar_container.dart';

import '../../controller/controller/user_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  final UserController _userController = UserController();

  MyAppBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      // Set the background to white
      elevation: 0,
      // Remove shadow
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        // Give some top padding to ensure the text does not get cut off
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // Important to keep the column height minimal
          children: [
            Text(AppLocalizations.of(context)!.helloAppBarText,
                style: const TextStyle(color: Colors.grey, fontSize: 18)),
            Text(AppLocalizations.of(context)!.goodMorningAppBarText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text(_userController.user.value?.displayName ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 32,
          ),
          onPressed: () {
            // todo Search for properties and Widgets that in order
            // Define the action for the search button
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications,
            size: 32,
          ),
          onPressed: () {
            // Define the action for the notification button
          },
        ),
        const SizedBox(width: 8),
        // todo Circular Avatar
        UserCircularAvatarContainer(photoURL: _userController.user.value?.photoURL,),
        // Adds spacing between icon and avatar,
        const SizedBox(width: 16),
        // Optional: adds spacing at the end of the app bar
      ],
      iconTheme:
          const IconThemeData(color: Colors.black), // Set icon color to black
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      100); // Increase the height to comfortably fit all text
}
