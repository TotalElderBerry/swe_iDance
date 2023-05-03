import 'dart:convert';

import '../../../constants/api.dart';
import 'package:http/http.dart' as http;

class AttendanceAPI{
   static Future<dynamic> generateQr(int classId) async {
    String route = "/attendance/class/$classId/generate";
    String uri = "${ApiConstants.baseUrl}$route"; 
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
      );
      print("response");
      
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error attemdamce api");
    }
  }
  static Future<dynamic> attendStudent(int classId, int studentId) async {
    String route = "/attendance/class/$classId";
    String uri = "${ApiConstants.baseUrl}$route"; 
    final response = await http.post(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode(
            <String, dynamic>{
            "student_id": studentId,
          }
    ),
      );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error attemdamce api");
    }
  }
}