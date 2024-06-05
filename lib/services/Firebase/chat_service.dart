import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huxley/screens/controller/controller/user_controller.dart';
import 'package:get/get.dart';
import '../../screens/chat/models/user/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find<UserController>();

  Future<void> createUserFields(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> changeStatus(bool isActive) async {
    User? currentUser = _userController.user.value;
    await _firestore.collection('users').doc(currentUser?.uid).update({'isActive': isActive});
  }

  Future<List<UserModel>> getCurrentActiveUsers() async {
    User? currentUser = _userController.user.value;
    DocumentSnapshot<Map<String, dynamic>> currentUserDoc = await _firestore.collection('users').doc(currentUser?.uid).get();
    if (!currentUserDoc.exists) {
      return [];
    }

    UserModel currentUserModel = UserModel.fromDatabaseJson(currentUserDoc.data()!);

    List<UserModel> activeContacts = [];
    for (String contactId in currentUserModel.contactUids) {
      DocumentSnapshot<Map<String, dynamic>> contactDoc = await _firestore.collection('users').doc(contactId).get();
      if (contactDoc.exists) {
        UserModel contact = UserModel.fromDatabaseJson(contactDoc.data()!);
        if (contact.isActive) {
          activeContacts.add(contact);
        }
      }
    }
    return activeContacts;
  }


  Future<void> createChatFields(String chatId, Map<String, dynamic> chatData) async {
    await _firestore.collection('chats').doc(chatId).set(chatData);
  }


  Future<Map<String, dynamic>?> getUserFields() async {
    User? currentUser = _userController.user.value;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser?.uid).get();
    return snapshot.data() as Map<String, dynamic>?;
  }


  Future<Map<String, dynamic>?> getChatFieldsByID(String chatId) async {
    DocumentSnapshot snapshot = await _firestore.collection('chats').doc(chatId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }


  Future<List<Map<String, dynamic>>> getChatMessageList(String chatId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }


  Future<void> sendFriendRequest(String recipientUsername) async {
    User? currentUser = _userController.user.value;
    if (currentUser == null || currentUser.uid.isEmpty) {
      throw Exception('Current user is not logged in or invalid');
    }

    QuerySnapshot recipientQuery = await _firestore.collection('users')
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
