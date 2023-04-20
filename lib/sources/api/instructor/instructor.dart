import 'dart:convert';

import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:http/http.dart' as http;

class InstructorAPI {
  static void addInstructor(InstructorModel newInstructor) async {
    const route = '/instructor/add';
    final response = http.post(Uri.parse(ApiConstants.baseUrl+route),
    body: jsonEncode(
      <String, String>{
        "user_id": newInstructor.userId,
        "rating": newInstructor.rating.toString(),
        "dance_description": newInstructor.description,
      }
    ),
    
    );
  }

  static void getInstructor(String id){
    final route = "instructor/${id}";

  }
}