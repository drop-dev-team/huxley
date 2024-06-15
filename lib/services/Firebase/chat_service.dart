
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huxley/screens/controller/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../screens/chat/models/user/user_model.dart';
import '../../screens/chat/models/user/models/chats/chat_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._privateConstructor();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find<UserController>();

  ChatService._privateConstructor();

  factory ChatService() {
    return _instance;
  }

  Future<void> createUserFields(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> changeStatus(bool isActive) async {
    User? currentUser = _userController.user.value;
    await _firestore
        .collection('users')
        .doc(currentUser?.uid)
        .update({'isActive': isActive});
  }

  Future<List<UserModel>> getCurrentActiveUsers() async {
    User? currentUser = _userController.user.value;
    DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
        await _firestore.collection('users').doc(currentUser?.uid).get();
    if (!currentUserDoc.exists) {
      return [];
    }

    UserModel currentUserModel =
        UserModel.fromDatabaseJson(currentUserDoc.data()!);

    List<UserModel> activeContacts = [];
    for (String contactId in currentUserModel.contactUids) {
      DocumentSnapshot<Map<String, dynamic>> contactDoc =
          await _firestore.collection('users').doc(contactId).get();
      if (contactDoc.exists) {
        UserModel contact = UserModel.fromDatabaseJson(contactDoc.data()!);
        if (contact.isActive) {
          activeContacts.add(contact);
        }
      }
    }
    return activeContacts;
  }

  Future<void> createChatFields(
      String chatId, Map<String, dynamic> chatData) async {
    await _firestore.collection('chats').doc(chatId).set(chatData);
  }

  Future<Map<String, dynamic>?> getUserFields() async {
    User? currentUser = _userController.user.value;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser?.uid).get();
    return snapshot.data() as Map<String, dynamic>?;
  }


  Future<List<Map<String, dynamic>>> getUserChats() async {
    String? currentUID = _userController.user.value?.uid;

    if (currentUID == null) {
      throw Exception('User not logged in');
    }

    // Retrieve the user document to get the array of chat IDs
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUID).get();

    // Ensure the data is treated as a map
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

    // Handle possible null userData
    if (userData == null) {
      return []; // or throw an exception, depending on your error handling policy
    }

    List<dynamic> chatIds = userData['chats'] ?? [];

    // List to hold all the chat details
    List<Map<String, dynamic>> chatDetails = [];

    // Loop over each chatId and fetch the chat document
    for (String chatId in chatIds) {
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      if (chatDoc.exists) {
        // Add data, ensuring it's a map
        chatDetails.add(chatDoc.data() as Map<String, dynamic>);
      }
    }

    return chatDetails;
  }


  Future<Map<String, dynamic>?> getChatFieldsByID(String chatId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('chats').doc(chatId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  Future<List<Map<String, dynamic>>> getChatMessageList(String chatId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> createChatID(String chatTitle, String chatType) async {
    try {
      String newChatId = await generateUniqueChatId(chatIdExists);
      String? currentUserId = _userController.user.value?.uid; // Get the current user's UID

      if (currentUserId == null) {
        throw Get.snackbar("Auth Error", "User is not logged in"); // Ensure the user is logged in
      }

      // Initialize a ChatModel object
      ChatModel newChat = ChatModel(
        chatId: newChatId,
        chatTitle: chatTitle,
        createdAt: Timestamp.now(),
        memberIds: [currentUserId], // Add current user UID to members
        chatType: chatType,
        lastMessage: null,
        lastActive: null,
        extraInfo: null,
      );

      // Save the chat model to Firestore
      await _firestore.collection('chats').doc(newChatId).set(newChat.toDatabaseJson());
      Get.snackbar("Success Indicator", "Created chat with ID: $newChatId successfully");
      // print("Chat created with ID: $newChatId");
      await _firestore.collection('users').doc(currentUserId).update({
        'chats': FieldValue.arrayUnion([newChatId])  // Append the new chat ID to the 'chats' array in the user's document
      });
    } catch (e) {
      Get.snackbar("Indicator Error", "Error: Failed to create chat ID: $e");
      throw("Failed to create chat ID: $e");
    }
  }

  // Check if the chat ID already exists in the Firestore database
  Future<bool> chatIdExists(String chatId) async {
    var document = await _firestore.collection('chats').doc(chatId).get();
    return document.exists;
  }

  // Generate a unique chat ID that does not collide with existing IDs
  Future<String> generateUniqueChatId(
      Future<bool> Function(String) checkCollision) async {
    var uuid = const Uuid();
    String newChatId;
    do {
      newChatId = uuid.v1();
      await Future.delayed(const Duration(milliseconds: 10));  // Delay to prevent hitting generation limits
    } while (await checkCollision(newChatId));
    return newChatId;
  }

  Future<void> sendFriendRequest(String recipientUsername) async {
    User? currentUser = _userController.user.value;
    if (currentUser == null || currentUser.uid.isEmpty) {
      throw Exception('Current user is not logged in or invalid');
    }

    QuerySnapshot recipientQuery = await _firestore
        .collection('users')
        .where('username', isEqualTo: recipientUsername)
        .limit(1)
        .get();

    if (recipientQuery.docs.isEmpty) {
      throw Exception('Recipient user not found');
    }

    var recipientId = recipientQuery.docs.first.id;

    // Check if the recipient is not the same as the sender
    if (recipientId == currentUser.uid) {
      throw Exception("You cannot send a friend request to yourself.");
    }

    // Add sender's ID to recipient's receivedFriendRequests
    await _firestore.collection('users').doc(recipientId).update({
      'receivedFriendRequests': FieldValue.arrayUnion([currentUser.uid])
    });

    // Add recipient's ID to sender's sentFriendRequests
    await _firestore.collection('users').doc(currentUser.uid).update({
      'sentFriendRequests': FieldValue.arrayUnion([recipientId])
    });
  }

  Future<void> acceptFriendRequest(String requesterId) async {
    User? currentUser = _userController.user.value;
    if (currentUser == null || currentUser.uid.isEmpty) {
      throw Exception('Current user is not logged in or invalid');
    }

    if (requesterId == currentUser.uid) {
      throw Exception("You cannot accept your own friend request.");
    }

    String userId = currentUser.uid;
    // Remove requesterId from receivedFriendRequests and add to contactUids
    await _firestore.collection('users').doc(userId).update({
      'receivedFriendRequests': FieldValue.arrayRemove([requesterId]),
      'contactUids': FieldValue.arrayUnion([requesterId])
    });

    // Remove userId from requester's sentFriendRequests and add to contactUids
    await _firestore.collection('users').doc(requesterId).update({
      'sentFriendRequests': FieldValue.arrayRemove([userId]),
      'contactUids': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> rejectFriendRequest(String requesterId) async {
    User? currentUser = _userController.user.value;
    if (currentUser == null || currentUser.uid.isEmpty) {
      throw Exception('Current user is not logged in or invalid');
    }

    String userId = currentUser.uid;
    if (requesterId == userId) {
      throw Exception("You cannot reject your own friend request.");
    }

    // Simply remove the requesterId from receivedFriendRequests
    await _firestore.collection('users').doc(userId).update({
      'receivedFriendRequests': FieldValue.arrayRemove([requesterId])
    });

    // Remove userId from requester's sentFriendRequests
    await _firestore.collection('users').doc(requesterId).update({
      'sentFriendRequests': FieldValue.arrayRemove([userId])
    });
  }
}
