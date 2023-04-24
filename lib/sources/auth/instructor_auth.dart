import 'dart:convert';

import 'package:i_dance/models/instructor.dart';

import '../../constants/api.dart';
import '../../models/student.dart';
import 'package:http/http.dart' as http;

import '../localstorage/localstorage.dart';


class StudentInstructorAuth{
  static Future<StudentModel> getProfileStudentbyId(String id) async {
    print("hahah $id");
    final route = '/student/me/$id';
    try {
      final response = await http.get(
         Uri.parse(ApiConstants.baseEmuUrl+route),
          headers: {
              "Content-Type": "application/json"
            },
        );

      print("response");
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200){
        print("200");
        Map<String, dynamic> json = jsonDecode(response.body)[0];
        LocalStorageSource.writeToStorage('instructor_token',(json['token'] != null)?json['token']:'');
        print("response 200");
        return StudentModel.fromJson(jsonDecode(response.body)[0]);
      } else {
        throw Exception('Failed to get');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<InstructorModel> getProileInstructor() async {
    final route = '/profile/me';
    final response = await http.get(
      Uri.parse(ApiConstants.baseEmuUrl+route),
       headers: {
            "Content-Type": "application/json"
          },
    );

    if(response.statusCode == 200) {
      return InstructorModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed');
  }
}