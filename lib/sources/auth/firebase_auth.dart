import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_dance/models/user.dart';

class Authentication{
  static var auth = FirebaseAuth.instance;

  Future<User> signInWithCredentials(String email, String password)async{
    final user = await auth.signInWithEmailAndPassword(email: email,password: password);
    return user.user!;
  }
  
  

}