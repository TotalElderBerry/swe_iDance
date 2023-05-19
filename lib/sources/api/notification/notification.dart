import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/api.dart';

class NotificationAPI{
  static Future<dynamic> getNotificationsOfUser(String id) async{
    final route = '/notification/$id';

    final response = await http.get(Uri.parse(Uri.encodeFull(ApiConstants.baseEmuUrl+route)),
    headers: {
            "Content-Type": "application/json"
          },
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("error sa notifs");
    }
  }
}