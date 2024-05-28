import '../containers/active_users_side_list.dart';
import '../containers/app_bar_chat_container.dart';
import '../containers/chat_list_container.dart';
import '../tests/test_class.dart';

import 'package:flutter/material.dart';

class ChatBlueprint extends StatelessWidget {
  final TestClass _testClass = TestClass();

  ChatBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 100, // Adjust the height according to your design
            child: ActiveUsersSideList(),  // Displays the horizontal list of active users
          ),
          const Expanded(
            child: ChatListContainer(),  // Takes the remaining space for chat list
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _testClass.creatingUser();
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
