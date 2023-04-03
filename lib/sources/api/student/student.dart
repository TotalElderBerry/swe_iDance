import 'dart:convert';

import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/student.dart';

import 'package:http/http.dart' as http;

class StudentAPI {
  static void addStudent(StudentModel newUser) async {
    const route = "student/add";
    final response = await http.post(Uri.parse('${ApiContstants.baseUrl} + ${route}'),
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
      }
    )
    );
  }

  static Future<StudentModel> getStudentbyId(String id) async {
    final route = "student/${id}";
    final response = await http.get(
        Uri.parse('${ApiContstants.baseUrl} + ${route}'),
      );

    if(response.statusCode == 200){
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get');
    }
  }
}