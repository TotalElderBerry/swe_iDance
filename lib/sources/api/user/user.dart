import 'dart:convert';

import 'package:i_dance/constants/api.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  static void addUser(UserModel newUser) async {
    const route = "student/add";
    final response = await http.post(Uri.parse('${ApiContstants.baseUrl} + ${route}'),
    body: jsonEncode(
      <String, String> {
        "id": newUser.id,
        "firstName": newUser.firstName,
        "lastName": newUser.lastName,
        "level": newUser.level,
        "gender": newUser.gender,
        "contactNumber": newUser.gender,
        "emailAddress": newUser.emailAddress,
        "dateOfBirth": newUser.dateOfBirth.toString()
      }
    )
    );
  }
}