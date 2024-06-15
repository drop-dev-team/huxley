import 'package:flutter/material.dart';
import '../../../models/user/models/message/message_model.dart';
import '../../../models/user/models/message/message_type_enum.dart';
import '../widgets/audio_message_widget.dart';
import '../widgets/image_link_message_widget.dart';
import '../widgets/image_message_widget.dart';
import '../widgets/link_message_widget.dart';
import '../widgets/text_image_message_widget.dart';
import '../widgets/text_link_message_widget.dart';
import '../widgets/text_message_widget.dart';

class MessageBuilder {
  final List<MessageModel> messages;
  final String currentUserId;

  MessageBuilder({required this.messages, required this.currentUserId});

  Widget buildMessage(MessageModel message) {
    switch (message.messageType) {
      case MessageType.text:
        return _buildTextMessage(message);
      case MessageType.image:
        return _buildImageMessage(message);
      case MessageType.audio:
        return _buildAudioMessage(message);
      case MessageType.link:
        return _buildLinkMessage(message);
      case MessageType.textImage:
        return _buildTextImageMessage(message);
      case MessageType.textLink:
        return _buildTextLinkMessage(message);
      case MessageType.imageLink:
        return _buildImageLinkMessage(message);
      default:
        return SizedBox.shrink();  // Fallback for unsupported message types
    }
  }

  Widget _buildTextMessage(MessageModel message) {
    return TextMessage(message: message, currentUserId: currentUserId);
  }

  Widget _buildImageMessage(MessageModel message) {
    return ImageMessage(currentUserId: currentUserId);
  }

  Widget _buildAudioMessage(MessageModel message) {
    return AudioMessage(currentUserId: currentUserId);
  }

  Widget _buildLinkMessage(MessageModel message) {
    return LinkMessage(currentUserId: currentUserId);
  }

  TextImageMessage _buildTextImageMessage(MessageModel message) {
    return TextImageMessage(currentUserId: currentUserId);
  }

  Widget _buildTextLinkMessage(MessageModel message) {
    return TextLinkMessage(currentUserId: currentUserId);
  }

  Widget _buildImageLinkMessage(MessageModel message) {
    return ImageLinkMessage(currentUserId: currentUserId);
  }

  List<Widget> buildMessageList() {
    return messages.map((message) => buildMessage(message)).toList();
  }
}
