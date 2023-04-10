import 'dart:convert';

import 'package:i_dance/models/instructor.dart';

import '../../constants/api.dart';
import '../../models/student.dart';
import 'package:http/http.dart' as http;

import '../localstorage/localstorage.dart';


class StudentInstructorAuth{
  static Future<StudentModel> getProfileStudentbyId(String id) async {
    final route = "/student/me/${id}";
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl} + $route'),
      );

    if(response.statusCode == 200){

      Map<String, dynamic> json = jsonDecode(response.body);
      LocalStorageSource.writeToStorage('instructor_token',(json['token'])?json['token']:null);
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get');
    }
  }

  static Future<InstructorModel> getProileInstructor() async {
    final route = '/profile/me';
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl} + ${route}'),
    );

    if(response.statusCode == 200) {
      return InstructorModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed');
  }
}