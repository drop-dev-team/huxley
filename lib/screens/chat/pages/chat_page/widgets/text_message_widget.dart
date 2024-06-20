import 'package:flutter/material.dart';
import '../../../models/user/models/message/message_model.dart';

class TextMessage extends StatelessWidget {
  final MessageModel message;
  final String currentUserId;  

  const TextMessage({super.key, required this.message, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId == currentUserId;  

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 8.0),
            child: CircleAvatar(
              radius: 20,
              child: Image.network(
                  message.senderPhotoURL,
                fit: BoxFit.fill,
              ),
            ),
          ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isMe ? Colors.lightBlue : Colors.grey[500],  
              borderRadius: BorderRadius.circular(16),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: SelectableText(
                message.text ?? "",  
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.senderPhotoURL),
              radius: 20,
            ),
          ),
      ],
    );
  }
}
