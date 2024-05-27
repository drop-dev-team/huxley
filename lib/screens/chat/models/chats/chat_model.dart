import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;           // Unique identifier for the chat
  final String chatTitle;        // Name or title of the chat
  final Timestamp createdAt;     // Timestamp of when the chat was created
  final List<String> memberIds;  // List of User IDs who are members of the chat
  final String chatType;         // Type of the chat ('single', 'group', 'ai')
  final String? lastMessage;     // Last message sent in the chat
  final Timestamp? lastActive;   // Timestamp of the last activity in the chat
  final Map<String, dynamic>? extraInfo;  // Additional information or settings for the chat

  ChatModel({
    required this.chatId,
    required this.chatTitle,
    required this.createdAt,
    required this.memberIds,
    required this.chatType,
    this.lastMessage,
    this.lastActive,
    this.extraInfo,
  });


  Map<String, dynamic> toDatabaseJson() {
    return {
      'chatId': chatId,
      'chatTitle': chatTitle,
      'createdAt': createdAt,
      'memberIds': memberIds,
      'chatType': chatType,
      'lastMessage': lastMessage,
      'lastActive': lastActive,
      'extraInfo': extraInfo,
    };
  }

  factory ChatModel.fromDatabaseJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'],
      chatTitle: json['chatTitle'],
      createdAt: json['createdAt'] as Timestamp,  // Ensure correct type conversion
      memberIds: List<String>.from(json['memberIds']),  // Cast to a list of strings
      chatType: json['chatType'],
      lastMessage: json['lastMessage'],
      lastActive: json['lastActive'] as Timestamp?,
      extraInfo: json['extraInfo'] as Map<String, dynamic>?,
    );
  }
}
