import 'package:i_dance/models/user.dart';

class StudentModel extends UserModel{
  String userId;
  int studentId;
  String level;
  int isInstructor;

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
      DateTime d = DateTime.parse(json['data_of_birth']);
      StudentModel newStudent =  StudentModel(json['student_id'], json['user_id'], firstName: json['first_name'], lastName: json['last_name'], gender: json['gender'], contactNumber: json['contact_number'], emailAddress: json['email_address'], dateOfBirth: d, level: json['level'], isInstructor: json['isInstructor']);
      newStudent.profilePicture = (json['profile_picture'] != null)?json['profile_picture']:'';
      return newStudent;
    }
}