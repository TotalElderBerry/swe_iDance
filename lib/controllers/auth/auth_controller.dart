import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:i_dance/constants/api.dart';
import 'package:i_dance/models/user.dart';
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



}