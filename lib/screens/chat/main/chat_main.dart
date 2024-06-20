import 'package:flutter/material.dart';
import 'package:huxley/screens/chat/pages/chats_list/blueprint/chat_blueprint.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: ChatBlueprint()
      ),
    );
  }
}
