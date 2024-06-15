import 'package:flutter/material.dart';
import '../builder/message_builder.dart';
import '../../../models/user/models/message/message_model.dart';

class MessageListContainer extends StatefulWidget {
  final List<MessageModel> messages;
  final String currentUserId;  // Current user ID is needed to align messages

  const MessageListContainer({super.key, required this.messages, required this.currentUserId});

  @override
  State<MessageListContainer> createState() => _MessageListContainerState();
}

class _MessageListContainerState extends State<MessageListContainer> {
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    messages = widget.messages;
  }

  // Method to add a new message and refresh the list
  void addMessage(MessageModel message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    MessageBuilder builder = MessageBuilder(messages: messages, currentUserId: widget.currentUserId);

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        // Use the builder to create the appropriate widget for each message
        return builder.buildMessage(messages[index]);
      },
    );
  }
}
