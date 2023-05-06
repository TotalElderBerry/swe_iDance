import 'package:i_dance/models/user.dart';

class InstructorModel extends UserModel{
  String? img;
  String userId;
  int instructorId;
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
      DateTime d = DateTime.parse(json['data_of_birth']);
    InstructorModel newInstructor = InstructorModel(json['user_id'], int.parse(json['instructor_id']), firstName: json['first_name'], lastName: json['last_name'], gender: json['gender'], contactNumber: json['contact_number'], emailAddress: json['email_address'], dateOfBirth: d, rating: int.parse(json['rating']), description: json['description']);
    newInstructor.profilePicture = (json['profile_picture'] != "")?json['profile_picture']:"";
    
    return newInstructor;
  }
}

    // "user_id": "xx22id",
    // "first_name": "Brian",
    // "last_name": "Lisondra",
    // "gender": "M",
    // "contact_number": "09154516111",
    // "email_address": "test@gmail.com",
    // "data_of_birth": "06/14/2001",
    // "profile_picture": null,
    // "instructor_id": 40,
    // "rating": 5,
    // "description": "tiktok",
    // "dance_specialty": "hiphip"