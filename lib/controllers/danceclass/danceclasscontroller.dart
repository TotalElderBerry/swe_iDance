import 'dart:io';

import 'package:get/get.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/sources/api/dance-class/dance-class.dart';

import '../../models/live_dance_class.dart';
import '../../models/student.dart';
import '../../sources/firebasestorage/firebase_storage.dart';
import '../student/student.dart';

class DanceClassController extends GetxController{
  List classes = ["Name1", "Name2"];
  RxList<LiveDanceClassModel> upcomingDanceClasses = <LiveDanceClassModel>[].obs;
  RxList<StudentModel> studentsApproved = <StudentModel>[].obs;
  RxList<StudentModel> studentsPending = <StudentModel>[].obs;

  void filterList(String query){

  }

  void addLiveDanceClass(LiveDanceClassModel liveDanceClass)async{
    print(Get.find<ImagePickerController>().imgPathDanceClass.value);
    final id = await DanceClassAPI.addDanceClass(liveDanceClass);
    await ImageCloudStorage.uploadDanceClassPicture(liveDanceClass.instructor.instructorId, id, File(Get.find<ImagePickerController>().imgPathDanceClass.value));
  }

  Future<bool> populateUpcomingClasses() async {
    bool hasFetched = false;
    print("in populate classes");
    upcomingDanceClasses.clear();
    try {
      final classes = await DanceClassAPI.getLiveDanceClasses();
      final upcoming = classes['upcoming_classes'];
    

      for(var upcomingClass in upcoming){
        print("loop");
        LiveDanceClassModel upClass = LiveDanceClassModel.fromJson(upcomingClass);
        upcomingDanceClasses.add(upClass);
      }
      hasFetched = true;
      await Get.find<StudentController>().getStudentDanceClass();
      
    } catch (e) {
      print("haha err");
      print(e);
    }
    return hasFetched;
  }

  Future<bool> getLiveDanceClassStudents(int live_danceclass_id) async {
    studentsApproved.clear();
    studentsPending.clear();
    try {
      final response = await DanceClassAPI.getLiveDanceClassStudents(live_danceclass_id);
      for(var booked in response){
        // print(response['student']);
        print(booked);
          StudentModel studentModel = StudentModel.fromJson(booked['student']);
          studentModel.profilePicture =  await ImageCloudStorage.getProfilePicture(studentModel.userId);
        if(booked['date_approved'] == 'PENDING'){
          studentsPending.add(studentModel);
        }else{
          studentsApproved.add(studentModel);
        }
      }
    } catch (e) {
      print("fooked");
      print(e);
    }
    return true;
  }

  void extractToBeShown(){
    for(int i = 0; i < upcomingDanceClasses.length; i++){
      if(Get.find<StudentController>().isBookedClasses(upcomingDanceClasses[i].liveClassId)){
        print("true");
      }
    }
  }
}