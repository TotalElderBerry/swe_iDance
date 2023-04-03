import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/models/user.dart';
import 'package:i_dance/sources/api/student/student.dart';
import 'package:i_dance/sources/api/user/user.dart';
import 'package:i_dance/sources/auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController{
  final Authentication authService = Authentication();
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  RxBool isLoggedIn = false.obs;
  RxString name = "".obs;
  Future<void> login(String email, String password)async{
    print(isLoggedIn.value);
    try{
      User user = await authService.signInWithCredentials(email,password);
      isLoggedIn.value = true;
      update();
    }catch(e){
      print(e);
    }
  }

  // change the code implementing inheritance

  Future<void> register(UserModel registeredUser, StudentModel student) async {
    try {
      User user = await authService.createUserWithEmailandPassword(registeredUser.emailAddress, registeredUser.password);
      registeredUser.id = user.uid;
      student.userId = user.uid;
      UserAPI.addUser(registeredUser);
      StudentAPI.addStudent(student);
    } catch (e) {
      print(e);
    }
  }

}