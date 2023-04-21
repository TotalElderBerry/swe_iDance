import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/api.dart';
import '../../../models/live_dance_class.dart';


class DanceClassAPI{
  static Future<int> addDanceClass(LiveDanceClassModel danceClass)async{
    const route = '/dance-class/add/live';
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl+route),
      body: danceClass.toJson() 
    );

    if(response.statusCode == 200){
      // return StudentModel.fromJson(jsonDecode(response.body));
      return jsonDecode(response.body)['insertId'];
    } else {
      throw Exception('Failed to get');
    }
  }

  static Future<Map<String, dynamic>> getLiveDanceClasses() async {
    String route = "/dance-class/live/all";
    String uri = "${ApiConstants.baseUrl}$route"; 
    final response = await http.get(
        Uri.parse('http://192.168.1.10:8000/api/dance-class/live/all'),
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
}