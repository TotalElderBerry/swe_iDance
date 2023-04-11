import 'dart:convert';

import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';

import 'package:http/http.dart' as http;
import 'package:i_dance/sources/localstorage/localstorage.dart';

class StudentAPI {
  static Future addStudent(StudentModel newUser) async {
    const route = "/student/add";
    print(newUser.firstName);

    final response = await http.post(Uri.parse('http://10.0.2.2:8000/api/student/add'),
    body: jsonEncode(
        <String, String> {
          "id": newUser.id,
          "firstName": newUser.firstName,
          "lastName": newUser.lastName,
          "gender": newUser.gender,
          "contactNumber": newUser.gender,
          "emailAddress": newUser.emailAddress,
          "dateOfBirth": newUser.dateOfBirth.toString(),
          "user_id": newUser.userId.toString(),
          "level": newUser.level,
          "isInstructor": newUser.isInstructor.toString(),
          "profilePicture": (newUser.profilePicture == null)?'':newUser.profilePicture.toString(),
        },
        
      ),
      headers: {
        "Content-Type": "application/json"
      },
    );
  }

  

  static Future<StudentModel> getStudentbyId(String id) async {
    final route = "/student/${id}";
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api + ${route}'),
          headers: {
            "Content-Type": "application/json"
          },
      );

    if(response.statusCode == 200){
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get');
    }
  }


  // to complete
  static Future<InstructorModel> switchToInstructor(String token) async {
    final route = '/instructor/profile/me';
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api + ${route}'),headers: {"Authorization": 'Bearer $token', "Content-Type": "application/json"});

    if(response.statusCode == 200){
      return InstructorModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Cannot get into Instructor Page');
  }
}