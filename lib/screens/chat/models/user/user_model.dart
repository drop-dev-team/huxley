import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String? email;
  final String? phoneNumber;
  final bool isActive;
  final String? profilePictureURL;
  final Timestamp? lastSeen;
  final List<String> chats;
  final List<String> contactUids;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.profilePictureURL,
    required this.lastSeen,
    required this.chats,
    required this.contactUids,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'profilePictureURL': profilePictureURL,
      'lastSeen': lastSeen,
      'chats': chats,
      'contactUids': contactUids
    };
  }

  factory UserModel.fromDatabaseJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        isActive: json['isActive'],
        profilePictureURL: json['profilePictureURL'],
        lastSeen: json['lastSeen'],
        chats: json["chats"],
        contactUids: json['contacts']);
  }
}
