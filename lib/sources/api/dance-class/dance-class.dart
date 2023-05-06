import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:i_dance/sources/localstorage/localstorage.dart';

import '../../../constants/api.dart';
import '../../../models/live_dance_class.dart';
import '../../../models/recorded_dance_model.dart';


class DanceClassAPI{
  static Future<int> addDanceClass(LiveDanceClassModel danceClass)async{
    final token = LocalStorageSource.readFromStorage('instructor_token');
    const route = '/dance-class/add/live';
    final response = await http.post(
      Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
      body: jsonEncode(danceClass.toJson()) ,
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Basic $token',
      },
    );

    if(response.statusCode == 200){
      // return StudentModel.fromJson(jsonDecode(response.body));
      return jsonDecode(response.body)['insertId'];
    } else {
      throw Exception('Failed to get');
    }
  }

  static Future<int> addRecordedDanceClass(RecordedDanceClassModel danceClass)async{
    final token = LocalStorageSource.readFromStorage('instructor_token');
    const route = '/dance-class/add/recorded';
    final response = await http.post(
      Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
      body: jsonEncode(danceClass.toJson()) ,
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Basic $token',
      },
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

  static Future<dynamic> getLiveDanceClassStudents(int live_danceclass_id)async {
    print(live_danceclass_id);
    String route = "/dance-class/live/$live_danceclass_id/students";
    final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
      );
      
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error etting live danceclasses students");
    }
  }

  static Future<dynamic> getStudentsAttended(int live_danceclass_id) async {
    print(live_danceclass_id);
    String route = "/dance-class/$live_danceclass_id/attendance";

		final response = await http.get(
        Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
          headers: {
            "Content-Type": "application/json"
          },
     	);

		if(response.statusCode == 200){
      print("in api danceclass ${response.body.toString()}");
			return jsonDecode(response.body);
		}else{
	      throw Exception("error etting live danceclasses attendance");
		}
  }
}