import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_type_enum.dart';


class MessageModel {
  final String messageId;       // Unique identifier for the message
  final String chatId;          // Identifier of the chat this message belongs to
  final String senderId;        // Identifier of the user who sent the message
  final MessageType messageType;// Type of the message
  final String? text;           // Text content of the message, if any
  final String? imageUrl;       // URL of the image, if any
  final String? audioUrl;       // URL of the audio, if any
  final String? linkUrl;        // URL of the link, if any
  final Timestamp timestamp;    // Timestamp when the message was sent

  MessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.messageType,
    this.text,
    this.imageUrl,
    this.audioUrl,
    this.linkUrl,
    required this.timestamp,
  });


  Map<String, dynamic> toDatabaseJson() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'messageType': messageType.toString().split('.').last,  // Convert enum to string
      'text': text,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'linkUrl': linkUrl,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromDatabaseJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      messageType: MessageType.values.firstWhere(
              (type) => type.toString().split('.').last == json['messageType'],
          orElse: () => MessageType.text  // Default to text if unknown
      ),
      text: json['text'],
      imageUrl: json['imageUrl'],
      audioUrl: json['audioUrl'],
      linkUrl: json['linkUrl'],
      timestamp: json['timestamp'] as Timestamp,
    );
  }
}
