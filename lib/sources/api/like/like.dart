import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/api.dart';

class LikeAPI {
  static Future<dynamic> getLikeFromStudent(int dance_class_id, int student_id)async{
    String route = "/like/class/$dance_class_id/student/$student_id";
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
      );
      
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error attemdamce api");
    }
  }

  static Future<dynamic> getLikesOfDanceClass(int dance_class_id)async{
    String route = "/like/class/$dance_class_id";
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
      );
      
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error attemdamce api");
    }
  }

  static Future<dynamic> setLike(int dance_class_id, int student_id)async{
    String route = "/like/class/$dance_class_id";
    String uri = "${ApiConstants.baseUrl}$route"; 
    final response = await http.post(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode(
            <String, dynamic>{
            "student_id": student_id,
          }
    ),
      );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}