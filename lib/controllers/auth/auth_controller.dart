import 'dart:convert';
import 'dart:ffi';

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
  Future<bool> login(String email, String password)async{
    print(isLoggedIn.value);
    try{
      User user = await authService.signInWithCredentials(email,password);
      print("i am  called");
      isLoggedIn.value = true;
      print(user);
      name.value = user.uid;
      // currentUser.value = await StudentAPI.getStudentbyId(user.uid);
      update();
      return true;
    }catch(e){
      print(e);
    }
    return false;
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

  Future<void> logout() async {
    isLoggedIn.value = false;
    name.value = '';
    currentUser.value = null;
    authService.logout();
  }

}