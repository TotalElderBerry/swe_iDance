import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/models/payment_details.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';

import '../../models/dance_class.dart';
import '../../models/instructor.dart';
import '../../models/recorded_dance_model.dart';
import '../../sources/api/instructor/instructor.dart';

class InstructorController extends GetxController{
  RxList<LiveDanceClassModel> instructorDanceClass = <LiveDanceClassModel>[].obs;
  RxList<RecordedDanceClassModel> instructorRecordedDanceClass = <RecordedDanceClassModel>[].obs;
  RxInt toShowLive = 0.obs;
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

    Future<bool> getLiveClassesOfInstructorbyId(InstructorModel instructor) async {
      print("get instructor");
      instructorDanceClass.clear();
      try {
        final response = await InstructorAPI.getLiveClassesOfInstructorbyId(instructor.instructorId);
        // LiveDanceClassModel ldance =LiveDanceClassModel.fromJson(response[0]);

        for(int i = 0; i < response.length; i++){
          LiveDanceClassModel ldance = LiveDanceClassModel(int.parse(response[i]['live_danceclass_id']), date: response[i]['date'], location: response[i]['location'], studentLimit: int.parse(response[i]['student_limit']), danceClassId: int.parse(response[i]['dance_id']), danceName: response[i]['dance_name'], danceSong: response[i]['dance_song'], danceDifficulty: response[i]['dance_difficulty'], price: int.parse(response[i]['price']), description: response[i]['description'], payment: PaymentDetails.fromJson(response[i]['payment']), instructor: instructor);

          instructorDanceClass.add(ldance);

          print(ldance.liveClassId);
        }

        
      } catch (e) {
        print(e);
      }
      return true;
    }

    Future<bool> acceptStudentBooking(int studentId, int danceClassId)async{
      try {
         final response = await InstructorAPI.acceptStudentDanceBooking(studentId, danceClassId);
         return true;
      } catch (e) {
        return false;
      }
    }  
}