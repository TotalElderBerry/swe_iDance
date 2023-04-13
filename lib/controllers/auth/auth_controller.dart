import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/models/user.dart';
import 'package:i_dance/sources/api/student/student.dart';
import 'package:i_dance/sources/api/user/user.dart';
import 'package:i_dance/sources/auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:i_dance/sources/localstorage/localstorage.dart';

import '../../sources/auth/instructor_auth.dart';

class AuthController extends GetxController{
  final Authentication authService = Authentication();
  Rx<StudentModel?> currentUser = Rx<StudentModel?>(null);
  Rx<InstructorModel?> currentInstructor = Rx<InstructorModel?>(null);
  
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
      currentUser.value = await StudentInstructorAuth.getProfileStudentbyId(user.uid);
      try {
        currentInstructor.value = await StudentInstructorAuth.getProileInstructor();
      } catch (e) {
        return false;
      }
      update();
      return true;
    }catch(e){
      print(e);
    }
    return false;
  }


  Future<void> register(StudentModel registeredUser, String password) async {
    try {
      User user = await authService.createUserWithEmailandPassword(registeredUser.emailAddress, password);
      registeredUser.id = user.uid;
      StudentAPI.addStudent(registeredUser);
    } catch (e) {
      print(e);
    }
  }

  String getLoggedUserId()  {
    return authService.getUser()!.uid;
  }

  Future<StudentModel> getLoggedStudent() async {
    try {
      currentUser.value = await StudentInstructorAuth.getProfileStudentbyId(authService.getUser()!.uid);
      print("auth");
      print(authService.getUser()!.uid);
      isLoggedIn.value = true;
    } catch (e) {
      print("fuck eror");
      print(e);      
    }
    
    return currentUser.value!;
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    name.value = '';
    currentUser.value = null;
    currentInstructor.value = null;
    LocalStorageSource.deleteStorage('instructor_token');
    authService.logout();
  }

}