import 'dart:isolate';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/sources/api/attendance/attendance.dart';
import 'package:i_dance/sources/api/student/student.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';
import 'package:i_dance/widgets/instructor/dance_class_card.dart';

import '../../models/dance_booking.dart';
import '../../models/dance_class.dart';
import '../../models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';
import '../../sources/api/like/like.dart';

class StudentController extends GetxController{

  RxList<DanceBooking> studentBookingClasses = <DanceBooking>[].obs;
  RxList<DanceBooking> studentDone = <DanceBooking>[].obs;
  RxList<DanceBooking> filteredBookingClass = <DanceBooking>[].obs;
  RxList<DanceBooking> filteredRecordedBookingClass = <DanceBooking>[].obs;

  RxList<LiveDanceClassModel> likedClasses = <LiveDanceClassModel>[].obs;
  RxList<RecordedDanceClassModel> likedRecordedClasses = <RecordedDanceClassModel>[].obs;
  RxBool isPending = false.obs;
  RxBool isDone = false.obs;
  RxBool isLiked = false.obs;

  RxBool isRecordingPending = false.obs;
  RxBool isRecordingBooked = false.obs;
  RxBool isRecordingLiked = false.obs;

  RxBool isLivePanel = true.obs;
  void getStudentbyId(){
    
  }


  //to fix
  List<DanceBooking> getBookedClasses(){
     return studentBookingClasses.where((element) => element.dateApproved != 'PENDING' && element.liveDanceClass != null).toList();
  }

  List<DanceBooking> getPendingClasses(){
    return studentBookingClasses.where((element) => element.dateApproved == 'PENDING' && element.liveDanceClass != null).toList();
  }

  List<DanceBooking> getPendingRecordedClasses(){
    print("i am called");
    return studentBookingClasses.where((element) => element.dateApproved == 'PENDING' && element.recordedDanceClass != null).toList();
  }

  List<DanceBooking> getBookedRecordingClasses(){
     return studentBookingClasses.where((element) => element.dateApproved != 'PENDING' && element.recordedDanceClass != null).toList();
  }

  List<DanceBooking> getDoneClasses(){
    List<DanceBooking> temp = [];
    for(int i = 0; i < Get.find<DanceClassController>().doneDanceClasses.length;i++){
      final t = studentDone.where((element) => element.danceClassId == Get.find<DanceClassController>().doneDanceClasses[i].danceClassId).toList();
      if(t.isNotEmpty){
        temp.add(t[0]);
      }
    }
    return temp;
  }

  List<DanceClassModel> getLikedClasses(){
    return likedClasses;
  }


  //FIX HEREEE!!!
  Future<bool> getStudentDanceClass()async{
    try {
      studentBookingClasses.clear();
      likedClasses.clear();
      List<LiveDanceClassModel> listtemp = Get.find<DanceClassController>().upcomingDanceClasses;
      List<RecordedDanceClassModel> recordtemp = Get.find<DanceClassController>().recordedClasses;

      for(int i = 0; i < listtemp.length; i++){
        if(listtemp[i].isLiked == 1){
          likedClasses.add(listtemp[i]);
        }
      }

      for(int i = 0; i < recordtemp.length; i++){
        if(recordtemp[i].isLiked == 1){
          likedRecordedClasses.add(recordtemp[i]);
        }
      }

      final response = await StudentAPI.getStudentDanceClasses(Get.find<AuthController>().currentUser.value!.studentId);
      
      for(int i = 0; i < Get.find<DanceClassController>().recordedClasses.length;i++){
        for(int j = 0;j < response.length;j++){
          if(response[j]['dance_class_id'] == Get.find<DanceClassController>().recordedClasses[i].danceClassId){
            print("GET STUDSENT record");
            // print(response[j].toString());
            DanceBooking danceBooking = DanceBooking();
            danceBooking.liveDanceClass = null;
            danceBooking.recordedDanceClass = Get.find<DanceClassController>().recordedClasses[i];
            danceBooking.dateApproved = response[j]['date_approved'];
            danceBooking.danceClassId = response[j]['dance_class_id'];
            Payment p = Payment.fromJson(response[j]['payment']);
            danceBooking.payment = p;
            studentBookingClasses.add(danceBooking);
            // Get.find<DanceClassController>().recordedClasses.remove(Get.find<DanceClassController>().recordedClasses[i]);
          }
        }
      }
      
      for(int i = 0; i < Get.find<DanceClassController>().upcomingDanceClasses.length;i++){
        for(int j = 0; j < response.length;j++){
          print(response.length);
          if(response[j]['dance_class_id'] == Get.find<DanceClassController>().upcomingDanceClasses[i].danceClassId){
              DanceBooking danceBooking = DanceBooking();
              danceBooking.liveDanceClass = Get.find<DanceClassController>().upcomingDanceClasses[i];
              danceBooking.dateApproved = response[j]['date_approved'];
              danceBooking.danceClassId = response[j]['dance_class_id'];
              Payment p = Payment.fromJson(response[j]['payment']);
              danceBooking.payment = p;
              studentBookingClasses.add(danceBooking);
              Get.find<DanceClassController>().upcomingDanceClasses.remove(Get.find<DanceClassController>().upcomingDanceClasses[i]);
              // listtemp.removeAt(i);
          }
        }
      }

    for(int i = 0; i < Get.find<DanceClassController>().doneDanceClasses.length;i++){
        for(int j = 0; j < response.length;j++){
          print(response.length);
          if(response[j]['dance_class_id'] == Get.find<DanceClassController>().doneDanceClasses[i].danceClassId){
              DanceBooking danceBooking = DanceBooking();
              danceBooking.liveDanceClass = Get.find<DanceClassController>().doneDanceClasses[i];
              danceBooking.dateApproved = response[j]['date_approved'];
              danceBooking.danceClassId = response[j]['dance_class_id'];
              Payment p = Payment.fromJson(response[j]['payment']);
              danceBooking.payment = p;
              studentDone.add(danceBooking);
              // listtemp.removeAt(i);
          }

        }
        
    }
      
      return true;
    } catch (e) {
      print("error kuha student's danceclass");
      print(e);
      return false;
    }
  }

  bool isBookedClasses(int class_id){
      int i;
      // for(i = 0; i < studentBookingClasses.length && studentBookingClasses[i].danceClassId != class_id;i++){
      //       print("niside ${studentBookingClasses[i].liveDanceClass!.liveClassId}");
      // }
      //       print("2 niside ${studentBookingClasses[i].liveDanceClass!.liveClassId} $i");

      // return (i < studentBookingClasses.length)?true:false;
    return true;
  }

  Future<bool> bookDanceClass(int dance_class_id, String referenceNumber, int price) async {
    return await StudentAPI.bookDanceClass(Get.find<AuthController>().currentUser.value!.studentId, dance_class_id, referenceNumber, price,Get.find<AuthController>().currentUser.value!.firstName +" "+Get.find<AuthController>().currentUser.value!.lastName);
  }



  Future<bool> giveRatingToInstructor(int instructorId, int rating)async{
    try {
        await StudentAPI.rateInstructor(instructorId, rating);
        return true;
    } catch (e) {
      return false;
    }
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

  Future<bool> attendDanceClass(int studentId, int liveClassId) async {
    try {
        return await AttendanceAPI.attendStudent(liveClassId, studentId);
    } catch (e) {
      return false;
  }
  }

  Future<bool> likeDanceClass(int dance_class_id) async {
    try {
      await LikeAPI.setLike(dance_class_id, Get.find<AuthController>().currentUser.value!.studentId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

}