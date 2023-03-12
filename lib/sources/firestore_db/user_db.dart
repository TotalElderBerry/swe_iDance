import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_dance/models/user.dart';

class UserDB{
  static final userDb = FirebaseFirestore.instance;

  Future<UserModel> getUserbyId(String id) async {
      var user = userDb.collection("users").doc(id);
      return UserModel.fromFirestore(user);
  }
}