import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;



class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Uploads a single file and returns the URL
  Future<String> uploadFile(File file) async {
    String fileName = path.basename(file.path);
    try {
      Reference ref = _storage.ref('uploads/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload file: $e");
    }
  }

  Future<String> uploadUserProfilePictureFile(File file, String userUid) async {
    String fileName = path.basename(file.path);
    try {
      // Store the file in a user-specific folder based on their UID
      Reference ref = _storage.ref('$userUid/profilePicture/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload file: $e");
    }
  }


  // Uploads multiple files and returns their URLs
  Future<List<String>> uploadFiles(List<File> files) async {
    List<String> urls = [];
    for (File file in files) {
      String url = await uploadFile(file);
      urls.add(url);
    }
    return urls;
  }
}
