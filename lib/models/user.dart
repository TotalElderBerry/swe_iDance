import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String id;
  String firstName;
  String lastName;
  String gender;
  String level;
  String contactNumber;
  String emailAddress;
  String password;
  DateTime dateOfBirth;
  UserModel(this.id, {required this.firstName, required this.lastName, required this.gender, required this.contactNumber, required this.level ,required this.emailAddress, required this.password, required this.dateOfBirth});
  


  // factory UserModel.fromFirestore(DocumentReference<Map<String, dynamic>> data){
  //   DocumentSnapshot<Map<String, dynamic>> snap =  data.get() as DocumentSnapshot<Map<String, dynamic>>;
  //   var snapData = snap.data();
  //   return UserModel(snapData?['id'], snapData?['firstName'], snapData?['lastName']);
  // }
}
