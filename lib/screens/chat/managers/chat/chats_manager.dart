import '../../../../services/Firebase/chat_service.dart';
import '../../widgets/chat_card_item_widget.dart'; // Import your ChatService class

class ChatsManager {
  static final ChatsManager _instance = ChatsManager._privateConstructor();
  final ChatService _chatService = ChatService();  // Assuming ChatService is already implemented

  // Private constructor for Singleton
  ChatsManager._privateConstructor();

  // Factory constructor to access the singleton instance
  factory ChatsManager() {
    return _instance;
  }

  /// Fetch user chats and convert them into a list of ChatCardItem
  Future<List<ChatCardItem>> getUserChats() async {
    List<Map<String, dynamic>> chatData = await _chatService.getUserChats();
    return chatData.map((chat) {
      return ChatCardItem(
        name: chat['lastMessage'] ?? 'No messages yet',
        message: chat['chatTitle'],
        time: 'No messages yet',
      );
    }).toList();
  }
}
