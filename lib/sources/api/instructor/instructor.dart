import 'dart:convert';

import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:http/http.dart' as http;

class InstructorAPI {
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
  
}