
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huxley/screens/chat/pages/chat_page/builder/message_builder.dart';
import 'package:huxley/services/Firebase/chat_service.dart';

import '../../models/user/models/message/message_model.dart';
import '../../models/user/models/message/message_type_enum.dart';

///This class will manage all messages features meaning it will just only do work on request and
///request work on need this makes Services calls more efficient since there's no need to keep
///services calls alive if not necessary.
class MessagesManager {

  final ChatService _chatService = ChatService();

  Future<MessageBuilder> getChatGroupMessagesByID(String chatID, String currentUserId) async {
    // Use getChatMessageList to fetch messages
    List<Map<String, dynamic>> messageDataList = await _chatService.getChatMessageList(chatID);

    // Map documents to MessageModel instances
    List<MessageModel> messages = messageDataList.map((data) {
      return MessageModel(
        messageId: data['id'] ?? "",  // Ensure 'id' or correct key is used
        text: data['text'] ?? "",
        senderId: data['senderId'] ?? "",
        timestamp: data['timestamp'] != null ? Timestamp.fromDate(DateTime.parse(data['timestamp'])) : Timestamp.now(),
        messageType: MessageType.values.firstWhere(
                (type) => type.toString().split('.').last == data['messageType'],
            orElse: () => MessageType.text
        ), senderDisplayName: data['senderDisplayName'], 
        senderPhotoURL: data['senderPhotoURL'], 
        chatId: data['chatId'],
        // Include other fields necessary for your message model
      );
    }).toList();

    // Create a MessageBuilder instance
    MessageBuilder messageBuilder = MessageBuilder(messages: messages, currentUserId: currentUserId);

    return messageBuilder;
  }




}
