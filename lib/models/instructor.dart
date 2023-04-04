import 'package:i_dance/models/user.dart';

class InstructorModel extends UserModel{
  String userId;
  String instructorId;
  int rating;
  String description;

  InstructorModel(
    this.userId, 
    this.instructorId, {    
    required String firstName,
    required String lastName,
    required String gender,
    required String contactNumber,
    required String emailAddress,
    required DateTime dateOfBirth,
    required this.rating, 
    required this.description,
  }):super(
    id: userId,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    contactNumber: contactNumber,
    emailAddress: emailAddress,
    dateOfBirth: dateOfBirth,
  );


}