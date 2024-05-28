import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/chat/models/user/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserFields(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> changeStatus(String userId, bool isActive) async {
    await _firestore.collection('users').doc(userId).update({'isActive': isActive});
  }

  Future<List<UserModel>> getCurrentActiveUsers(String currentUserId) async {
    DocumentSnapshot<Map<String, dynamic>> currentUserDoc = await _firestore.collection('users').doc(currentUserId).get();
    if (!currentUserDoc.exists) {
      return [];
    }

    UserModel currentUser = UserModel.fromDatabaseJson(currentUserDoc.data()!);

    List<UserModel> activeContacts = [];
    for (String contactId in currentUser.contactUids) {
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


  Future<Map<String, dynamic>?> getUserFields(String userId) async {
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
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
}
