import 'dart:convert';

import 'package:get/get.dart';
import 'package:i_dance/constants/api.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:http/http.dart' as http;

class InstructorAPI {

  static Future<void> updateStudent(InstructorModel instructor) async {
    
    final route = '/instructor/${instructor.instructorId}';
    final respone = await http.post(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    body: jsonEncode(
      <String,String> {
        "user_id": instructor.userId,
        "description": instructor.description
      }
    ),
    headers: {
        "Content-Type": "application/json"
      },
    );
  }

  static Future<String> addInstructor(InstructorModel newInstructor) async {
    const route = '/instructor/add';
    final response = await http.post(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    body: jsonEncode(
      <String, String>{
        "user_id": newInstructor.userId,
        "rating": newInstructor.rating.toString(),
        "description": newInstructor.description,
        "dance_specialty": "hiphip",
      }
    ),
    headers: {
            "Content-Type": "application/json"
          },
    );

    if(response.statusCode == 200){
      String token = jsonDecode(response.body)['token'];
      return token;
    }else{
      return '';
    }
  }

  static Future<InstructorModel> getInstructor(String id) async{
    final route = "instructor/${id}";
    final response = await http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    headers: {
            "Content-Type": "application/json"
          },
    );

    if(response.statusCode == 200){
      InstructorModel instructor = InstructorModel.fromJson(jsonDecode(response.body));
      return instructor;
    }else{
      throw Exception("error sa insructor");
    }
  }

  static Future<List<dynamic>> getLiveClassesOfInstructorbyId(int instructor_id)async{
    print(instructor_id);
    final route = "/instructor/${instructor_id}/live";
    final response = await http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    headers: {
            "Content-Type": "application/json"
          },
    );
    print(response);
    if(response.statusCode == 200){
     return jsonDecode(response.body);
    }else{
    print(response.statusCode);
      
      throw Exception("error sa get classes of instructor");
    }
  }

   static Future<dynamic> getRecordedDanceClassesOfInstructor(int instructorId) async {
    String route = "/instructor/${instructorId}/recorded";
    String uri = "${ApiConstants.baseUrl}$route"; 
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
      );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error etting live danceclasses");
    }
  }

  static Future<List<dynamic>> getInstructors()async{
    final route = "/instructor/all";
    final response = await http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    headers: {
            "Content-Type": "application/json"
          },
    );
    if(response.statusCode == 200){
     return jsonDecode(response.body);
    }else{
    print(response.statusCode);
      
      throw Exception("error sa get classes of instructor");
    }
  }

  static Future<dynamic> acceptStudentDanceBooking(int student_id, int dance_class_id) async {

    final route = "/instructor/live/$dance_class_id/accept-student";

    final response = await http.put(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
      body: jsonEncode(
      <String, dynamic>{
        "student_id": student_id,
      }
    ),
    headers: {
            "Content-Type": "application/json"
      },
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("API for acceptStudentBooking failed");
    }
    
  }
  
}