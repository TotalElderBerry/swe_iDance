import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  UserModel();

  factory UserModel.fromFirebaseUser(User? u){
    return UserModel();
  }
}