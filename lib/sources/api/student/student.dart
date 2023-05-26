import 'dart:convert';

import 'package:get/get.dart';
import 'package:i_dance/constants/api.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';

import 'package:http/http.dart' as http;
import 'package:i_dance/sources/localstorage/localstorage.dart';

class StudentAPI {

  static Future<void> updateStudent(StudentModel student) async {
    
    final route = '/student/${student.studentId}';
    final respone = await http.put(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    body: jsonEncode(
      <String,String> {
        "user_id": student.userId,
        "firstName": student.firstName,
        "lastName": student.lastName,
        "gender": student.gender,
        "contactNumber" : student.contactNumber,
        "dateOfBirth": student.contactNumber,
        "level": student.level
      }
    ),
    headers: {
        "Content-Type": "application/json"
      },
    );
  }

  static Future addStudent(StudentModel newUser) async {
    const route = "/student/add";

    final response = await  http.post(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
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

  static Future<List<dynamic>> getStudentDanceClasses(int student_id) async {
    final route = '/student/$student_id/classes';
    print(student_id);
    try {
      final response = await  http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
        headers: {
              "Content-Type": "application/json"
            },
        );
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("error getting student's danceclasses");
      }
      
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<StudentModel> getStudentbyId(String id) async {
    final route = "/student/${id}";
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
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

  //error naa dri
  static Future<InstructorModel> switchToInstructor(String token) async {
    final route = '/instructor/profile/me';
    final response = await http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
   
    headers: {
      'Authorization': 'Bearer $token', 
      "Content-Type": "application/json"
    });
    if(response.statusCode == 200){
      return InstructorModel.fromJson(jsonDecode(response.body)[0]);
    }else{
      throw Exception('Unauthorised ');
    }
  }

  static Future<bool> rateInstructor(int instructorId,int rating) async{
    final route = '/rating/instructor/${instructorId}';
    final response = await http.post(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
     body: jsonEncode(
        <String, dynamic> {
          "rating": rating,
          "student_id": Get.find<AuthController>().currentUser.value!.studentId
        },
        
      ),
      headers: {
        "Content-Type": "application/json"
      },
    );

    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Unauthorised ');
    }    
  }

  static Future<bool> bookDanceClass(int student_id, int dance_class_id,String referenceNumber, int price, String name) async {
    print("in dance book api");
    final route = '/student/book/class/$dance_class_id';
    String token = LocalStorageSource.readFromStorage('instructor_token');
    final response = await http.post(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    body: jsonEncode(
      <String, dynamic> {
        "student_id": student_id,
        "reference_number": referenceNumber,
        "amount": price,
        "sender_name": name
      }
    ),
    headers: {
      "Content-Type": "application/json"
    });
    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Unauthorised ');
    }
  }

  static Future<bool> cancelDanceClass(int studentId, int danceClassId) async {
    final route = '/student/$studentId/live/$danceClassId';
    String token = LocalStorageSource.readFromStorage('instructor_token');
    final response = await http.put(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    headers: {
      "Content-Type": "application/json"
    });
    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Unauthorised ');
    }
  }
}