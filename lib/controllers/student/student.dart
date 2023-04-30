import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/sources/api/student/student.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';
import 'package:i_dance/widgets/instructor/dance_class_card.dart';

import '../../models/dance_booking.dart';
import '../../models/live_dance_class.dart';

class StudentController extends GetxController{

  RxList<DanceBooking> studentBookingClasses = <DanceBooking>[].obs;
  RxList<DanceBooking> filteredBookingClass = <DanceBooking>[].obs;

  void getStudentbyId(){
    
  }


  //to fix
  void getBookedClasses(){
    print("called get booked dance classes");
     filteredBookingClass.value = studentBookingClasses.where((element) => element.dateApproved != 'PENDING').toList();
  }

  void getPendingClasses(){
    filteredBookingClass.value = studentBookingClasses.where((element) => element.dateApproved == 'PENDING').toList();
     print(filteredBookingClass.length);
  }


  //FIX HEREEE!!!
  Future<bool> getStudentDanceClass()async{
    try {
      studentBookingClasses.clear();
      final response = await StudentAPI.getStudentDanceClasses(Get.find<AuthController>().currentUser.value!.studentId);
      int i;
      for(i = 0; i < Get.find<DanceClassController>().upcomingDanceClasses.length;i++){
        final studentClass = Get.find<DanceClassController>().upcomingDanceClasses.where((element) => element.danceClassId == response[i]['dance_class_id']);
        print("student danceclassesnjhj");
        DanceBooking danceBooking = DanceBooking();
        danceBooking.liveDanceClass = studentClass.first;
        danceBooking.dateApproved = response[i]['date_approved'];
        Payment p = Payment.fromJson(response[i]['payment']);
        danceBooking.payment = p;
        studentBookingClasses.add(danceBooking);
      }
      print(studentBookingClasses.length);
      print("student danceclasses");
      return true;
    } catch (e) {
      print("erro");
      print(e);
      return false;
    }

  }

  Future<bool> bookDanceClass(int dance_class_id, String referenceNumber, int price){
    return StudentAPI.bookDanceClass(Get.find<AuthController>().currentUser.value!.studentId, dance_class_id, referenceNumber, price,Get.find<AuthController>().currentUser.value!.firstName +" "+Get.find<AuthController>().currentUser.value!.lastName);
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