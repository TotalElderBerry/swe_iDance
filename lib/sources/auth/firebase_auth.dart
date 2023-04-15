import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_dance/models/user.dart';

class Authentication{
  static var auth = FirebaseAuth.instance;

  Future<User> signInWithCredentials(String email, String password)async{
    final user = await auth.signInWithEmailAndPassword(email: email,password: password);
    return user.user!;
  }
  
  Future<User> createUserWithEmailandPassword(String email, String password) async {
    final user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return user.user!;
  }  
  
  void logout() async {
    await auth.signOut();
  }

  User? getUser(){
    print("firebase auth");
    print(FirebaseAuth.instance.currentUser);
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser;
    }else{
      return null;
    } 
  }

}