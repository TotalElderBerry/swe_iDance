import 'package:i_dance/models/user.dart';

class StudentModel extends UserModel{
  String userId;
  String level;
  int isInstructor;
 
  // change the code implementing inheritance

  StudentModel( this.userId, {required this.level, required this.isInstructor}):super();

}