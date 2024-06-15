import 'package:flutter/material.dart';
import 'package:huxley/screens/chat/pages/chat_page/blueprint/chat_blueprint.dart';

import '../containers/app_bar_container.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppBar(
        chatPhotoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKklq_kxC02-q7fedTEUU4NgLXQBf4zBbbpw&s",
        chatTitle: "Test Chat",
      ),
      body: SafeArea(
        child: ChatBlueprint(),
      ),
    );
  }
}
