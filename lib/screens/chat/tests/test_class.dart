import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/controller/controller/user_controller.dart';
import 'package:huxley/services/Firebase/chat_service.dart';

import '../models/user/user_model.dart';

class TestClass {
  final ChatService _dbService = ChatService();
  UserController userController = Get.find<UserController>();

  Future<void> creatingUser() async {
    final User? currentUser = userController.user.value;
    // Example user
    UserModel user = UserModel(
      id: currentUser?.uid ?? "Test User UID",
      username: currentUser?.displayName ?? "Test User User name ",
      email: currentUser!.email ?? "Test User Email@mock.com",
      isActive: true,
      phoneNumber: '+1234567890',
      profilePictureURL: currentUser.photoURL ?? "PHOTO URL",
      lastSeen: Timestamp.now(),
      chats: ["No Chats for the moment", "Dummy chats no chats to store"],
    );

    // Create or update user in Firestore
    await _dbService.createUserFields(user);
    print('User created/updated in Firestore with ID: ${user.id}');
  }
}
