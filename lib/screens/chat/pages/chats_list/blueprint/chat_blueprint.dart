import 'package:flutter/material.dart';
import 'package:huxley/services/Firebase/chat_service.dart';
import '../containers/active_users_side_list.dart';
import '../containers/app_bar_chat_container.dart'; // Assumes CustomAppBar is used here
import '../containers/chat_list_container.dart';
import '../../../tests/test_class.dart';

class ChatBlueprint extends StatefulWidget {
  const ChatBlueprint({super.key});

  @override
  State<ChatBlueprint> createState() => _ChatBlueprintState();
}

class _ChatBlueprintState extends State<ChatBlueprint> {
  final ChatService _chatService = ChatService();
  final TestClass _testClass = TestClass();  // Instance of TestClass
  bool _isSearchActive = false;  // Controls the display state of the search functionality

  void activateSearch(bool activate) {
    setState(() {
      _isSearchActive = activate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: CustomAppBar(),  // Your existing CustomAppBar
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
              autofocus: true,
              onTap: () => activateSearch(true),
              onChanged: (value) {
                if (value.isEmpty) {
                  // Deactivate search when text is cleared
                  activateSearch(false);
                } else {
                  // Activate search when text is being entered
                  activateSearch(true);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          if (!_isSearchActive)  // Only show other content if search is not active
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 100, // Height for ActiveUsersSideList
                    child: ActiveUsersSideList(),
                  ),
                  const Expanded(
                    child: ChatListContainer(), // Main chat list container
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: !_isSearchActive ? FloatingActionButton(  // Only show FAB when search is not active
        onPressed: () {
          _chatService.createChatID("Test Chat", "test");
          // _testClass.creatingUser();
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}
