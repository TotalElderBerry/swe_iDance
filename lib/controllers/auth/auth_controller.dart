import 'package:get/state_manager.dart';
import 'package:i_dance/models/user.dart';
import 'package:i_dance/sources/auth/firebase_auth.dart';
import 'package:i_dance/sources/firestore_db/user_db.dart';

class AuthController extends GetxController{
  final Authentication authService = Authentication();
  final UserDB userDB = UserDB();
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  var isLoggedIn = false.obs;

  
  Future<void> login(String email, String password)async{
    try{
      var user = await authService.signInWithCredentials(email,password);
      isLoggedIn = true.obs;
      currentUser.value = await userDB.getUserbyId(user.uid);
      update();
    }catch(e){
      print(e);
    }
  }


}