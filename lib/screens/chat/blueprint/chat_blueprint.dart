import 'package:flutter/material.dart';

import '../containers/app_bar_chat_container.dart';
import '../containers/chat_list_container.dart';
import '../tests/test_class.dart';

class ChatBlueprint extends StatelessWidget {
  final TestClass _testClass = TestClass();
  ChatBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const ChatListContainer(),
      extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
            onPressed: () => {
              _testClass.creatingUser()
            }
        )
    );
  }
}
