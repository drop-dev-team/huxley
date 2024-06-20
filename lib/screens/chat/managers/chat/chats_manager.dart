import '../../../../services/Firebase/chat_service.dart';
import '../../widgets/chat_card_item_widget.dart'; // Import your ChatService class

class ChatsManager {
  static final ChatsManager _instance = ChatsManager._privateConstructor();
  final ChatService _chatService = ChatService(); // Assuming ChatService is already implemented

  // Private constructor for Singleton
  ChatsManager._privateConstructor();

  // Factory constructor to access the singleton instance
  factory ChatsManager() {
    return _instance;
  }

  /// Fetch user chats and convert them into a list of ChatCardItem
  Future<List<ChatCardItem>> getUserChats() async {
    List<Map<String, dynamic>> chatData = await _chatService.getUserChats();

    return List.generate(chatData.length, (i) =>
        ChatCardItem(
          name: chatData[i]['chatTitle'] ?? 'No messages yet',
          message: chatData[i]['lastMessage'] ?? 'No Message yet yet',
          time: chatData[i]['createdAt'].toDate().toString().split(' ')[0],
          itemIndex: i,
        ),
    );
  }
}
