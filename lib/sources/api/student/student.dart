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
        "user_id": newUser.userId.toString(),
        "level": newUser.level,
        "isInstructor": newUser.isInstructor.toString(),
      }
    )
    );
  }

  static void getStudentbyId(String id) async {
    
  }
}