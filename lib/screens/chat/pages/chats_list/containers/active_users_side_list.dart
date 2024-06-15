import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';
import '../../../widgets/user_profiler_widget.dart';

class ActiveUsersSideList extends StatelessWidget {
  // Dummy data list of users
  final List<UserModel> dummyUsers = List.generate(5, (index) => UserModel(
    id: 'user$index',
    username: 'User $index',
    email: 'user$index@example.com',
    isActive: index % 2 == 0, // Alternating active status for demonstration
    profilePictureURL: "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png?20170328184010", // Assuming null, add your default or specific image path if needed
    phoneNumber: '123-456-7890',
    contactUids: [],
    chats: [],
    lastSeen: null,
  ));

  ActiveUsersSideList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height to fit the user profile items
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
        itemCount: dummyUsers.length,
        itemBuilder: (context, index) {
          UserModel user = dummyUsers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: UserProfileItem(
              profilePictureURL: user.profilePictureURL,
              isActive: user.isActive,
              username: user.username,
            ),
          );
        },
      ),
    );
  }
}
