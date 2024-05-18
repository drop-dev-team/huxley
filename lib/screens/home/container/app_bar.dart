import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white, // Set the background to white
      elevation: 0, // Remove shadow
      title: const Padding(
        padding: EdgeInsets.only(top:8), // Give some top padding to ensure the text does not get cut off
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Important to keep the column height minimal
          children: [
            Text("Hello,", style: TextStyle(color: Colors.grey, fontSize: 18)),
            Text("Good Morning", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
            Text("UserName", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, size: 32,),
          onPressed: () {
            // Define the action for the search button
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications, size: 32,),
          onPressed: () {
            // Define the action for the notification button
          },
        ),
        const SizedBox(width: 8), // Adds spacing between icon and avatar
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueGrey, // Set your desired color or background image
          child: Text('A'), // Typically initials or an image can be used
        ),
        const SizedBox(width: 16), // Optional: adds spacing at the end of the app bar
      ],
      iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // Increase the height to comfortably fit all text
}
