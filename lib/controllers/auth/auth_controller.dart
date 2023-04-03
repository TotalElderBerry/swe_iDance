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
  Rx<StudentModel?> currentUser = Rx<StudentModel?>(null);
  RxBool isLoggedIn = false.obs;
  RxString name = "".obs;
  Future<void> login(String email, String password)async{
    print(isLoggedIn.value);
    try{
      User user = await authService.signInWithCredentials(email,password);
      isLoggedIn.value = true;
      currentUser.value = await StudentAPI.getStudentbyId(user.uid);
      update();
    }catch(e){
      print(e);
    }
  }

  // change the code implementing inheritance

  Future<void> register(StudentModel registeredUser, String password) async {
    try {
      User user = await authService.createUserWithEmailandPassword(registeredUser.emailAddress, password);
      registeredUser.id = user.uid;
      StudentAPI.addStudent(registeredUser);
    } catch (e) {
      print(e);
    }
  }

}