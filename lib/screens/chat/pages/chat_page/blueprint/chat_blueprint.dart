import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/user/models/message/message_model.dart';
import '../../../models/user/models/message/message_type_enum.dart';
import '../containers/message_list_container.dart';
import '../containers/text_field_component.dart';

class ChatBlueprint extends StatefulWidget {
  const ChatBlueprint({super.key});

  @override
  State<ChatBlueprint> createState() => _ChatBlueprintState();
}

class _ChatBlueprintState extends State<ChatBlueprint> {
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    // Initialize messages with some mock data
    loadInitialMessages();
  }

  void loadInitialMessages() {
    messages = [
      // Existing messages
    ];
  }

  void addMessage(String text) {
    final newMessage = MessageModel(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: "chat1",
      senderId: 'user1',
      // Simulating current user ID
      messageType: MessageType.text,
      text: text,
      timestamp: Timestamp.now(),
      senderDisplayName: 'Current User',
      senderPhotoURL:
          'https://upload.wikimedia.org/wikipedia/commons/a/a2/Person_Image_Placeholder.png',
    );
    setState(() {
      messages.add(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessageListContainer(
            messages: messages,
            currentUserId:
                'user1', // Assuming 'user1' is the current logged-in user
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputFieldComponent(
            onSendPressed: (String text) {
              addMessage(text);
            },
          ),
        ),
      ],
    );
  }
}
