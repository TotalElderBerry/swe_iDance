import 'package:i_dance/models/user.dart';

class StudentModel extends UserModel{
  String userId;
  String studentId;
  String level;
  int isInstructor;
 
  // change the code implementing inheritance

  StudentModel( this.studentId, this.userId, {
    required String firstName,
    required String lastName,
    required String gender,
    required String contactNumber,
    required String emailAddress,
    required DateTime dateOfBirth,
    required this.level, 
    required this.isInstructor
    
    }):super(id: userId, firstName: firstName, lastName: lastName, gender: gender, contactNumber: contactNumber, emailAddress: emailAddress,dateOfBirth: dateOfBirth);

    factory StudentModel.fromJson(Map<String, dynamic> json){
      return StudentModel(json['student_id'], json['user_id'], firstName: json['first_name'], lastName: json['last_name'], gender: json['gender'], contactNumber: json['contact_number'], emailAddress: json['email_address'], dateOfBirth: json['data_of_birth'], level: json['level'], isInstructor: json['isInstructor']);
    }
}