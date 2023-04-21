import 'package:get/get.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';

import '../../models/instructor.dart';
import '../../sources/api/instructor/instructor.dart';

class InstructorController extends GetxController{
    Future<bool> addInstructor(InstructorModel newInstructor) async {
      print(newInstructor.description);
      try {
        String token = await InstructorAPI.addInstructor(newInstructor);
        print(token);
        LocalStorageSource.writeToStorage('instructor_token',token);
        return true;
      } catch (e) {
        print(e);
        return false;
      }

    }
}