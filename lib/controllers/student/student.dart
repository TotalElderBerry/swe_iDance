import 'package:get/state_manager.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/sources/api/student/student.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';

class StudentController extends GetxController{

  void getStudentbyId(){
    
  }

  void getStudentDanceClass(){

  }

  void bookDanceClass(){

  }

  void giveRatingToInstructor(){

  }

  Future<InstructorModel?> switchToInstructor() async {
    String token = LocalStorageSource.readFromStorage('instructor_token');
    print("token");
    print(token);
    if(token == '') return null;
    try {
      print(token);
      // print( StudentAPI.switchToInstructor(token));
      return await StudentAPI.switchToInstructor(token);
    } catch (e) {
      print("hi");
      throw Exception(e);
    }
    // print( LocalStorageSource.readFromStorage('instructor_token'));

  }

}