import 'package:get/state_manager.dart';
import 'package:i_dance/models/user.dart';
import 'package:i_dance/sources/auth/firebase_auth.dart';

class AuthController extends GetxController{
  final Authentication authService = Authentication();
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  bool isLoggedIn = false;

  
  Future<void> login(String email, String password)async{
    try{
      var user = await authService.signInWithCredentials(email,password);
      isLoggedIn = true.obs;
      update();
    }catch(e){

    }
  }


}