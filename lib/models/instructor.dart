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

  factory InstructorModel.fromJson(Map<String, dynamic> json){
    return InstructorModel(json['student_id'], json['user_id'], firstName: json['first_name'], lastName: json['last_name'], gender: json['gender'], contactNumber: json['contact_number'], emailAddress: json['email_address'], dateOfBirth: json['data_of_birth'], rating: json['rating'], description: json['description']);
  }
}