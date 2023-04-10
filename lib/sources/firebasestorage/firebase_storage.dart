import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ImageCloudStorage{
  static final storage = FirebaseStorage.instance.ref();

  void uploadImageInRef(String ref, File newFile) async {
    try {
      final imageRef = storage.child(ref);
      await imageRef.putFile(newFile);
    } catch (e) {
      
    }
  }  

  static Future<String> getProfilePicture(String id) async {
    return await storage.child('users/$id/profile_picture.jpg').getDownloadURL();
  }
  
  static Future<String?> uploadProfilePicture(String id, File profPic) async {
    try {
      final imageRef = storage.child('users/$id/profile_picture.jpg');
      await imageRef.putFile(profPic);
      return imageRef.getDownloadURL();
    } catch (e) {
      
    }
    return null;
  }
}