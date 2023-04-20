import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String id;
  String firstName;
  String lastName;
  String gender;
  String contactNumber;
  String emailAddress;
  DateTime dateOfBirth;
  String? profilePicture;

  UserModel({required this.id, required this.firstName, required this.lastName, required this.gender, required this.contactNumber, required this.emailAddress, required this.dateOfBirth});
  


}
