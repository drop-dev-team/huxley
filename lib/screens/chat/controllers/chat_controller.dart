import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../controller/controller/user_controller.dart';

class ChatController {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find<UserController>();


  // Singleton setup
  ChatController._privateConstructor();
  static final ChatController _instance = ChatController._privateConstructor();
  factory ChatController() => _instance;

  // Map to hold identifiers and chat details if necessary
  Map<String, Map<String, dynamic>> chatDetailsCache = {};

  // Method to fetch all chat details for a specific user and return them in a specific format
  Future<List<Map<String, Map<String, dynamic>>>> getUserChats() async {
    String? currentUID = _userController.user.value?.uid;

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUID).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userData == null) {
      return [];
    }

    List<dynamic> chatIds = userData['chats'] ?? [];
    List<Map<String, Map<String, dynamic>>> chatDetailsList = [];

    for (String chatId in chatIds) {
      if (chatDetailsCache.containsKey(chatId)) {
        // If the chat data is already cached, retrieve from cache
        chatDetailsList.add({chatId: chatDetailsCache[chatId]!});
      } else {
        DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
        if (chatDoc.exists) {
          Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
          chatDetailsCache[chatId] = chatData;  // Cache the chat data
          chatDetailsList.add({chatId: chatData});  // Add the chatId and its data as a Map to the list
        }
      }
    }

    return chatDetailsList;
  }
}
