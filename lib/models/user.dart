import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String id;
  String firstName;
  String lastName;

  UserModel(this.id, this.firstName, this.lastName);

  factory UserModel.fromFirestore(DocumentReference<Map<String, dynamic>> data){
    DocumentSnapshot<Map<String, dynamic>> snap =  data.get() as DocumentSnapshot<Map<String, dynamic>>;
    var snapData = snap.data();
    return UserModel(snapData?['id'], snapData?['firstName'], snapData?['lastName']);
  }
} 