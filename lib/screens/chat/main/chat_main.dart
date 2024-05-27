import 'package:flutter/material.dart';
import 'package:huxley/screens/chat/blueprint/chat_blueprint.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ChatBlueprint()
      ),
    );
  }
}
