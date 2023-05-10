import 'dart:io';

import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/sources/api/dance-class/dance-class.dart';
import 'package:i_dance/views/student/recorded_dance_class_booking.dart';

import '../../models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';
import '../../models/student.dart';
import '../../sources/api/attendance/attendance.dart';
import '../../sources/api/like/like.dart';
import '../../sources/firebasestorage/firebase_storage.dart';
import '../instructor/instructor.dart';
import '../student/student.dart';

class DanceClassController extends GetxController{
  List classes = ["Name1", "Name2"];
  RxList<LiveDanceClassModel> upcomingDanceClasses = <LiveDanceClassModel>[].obs;
  RxList<LiveDanceClassModel> doneDanceClasses = <LiveDanceClassModel>[].obs;
  RxList<StudentModel> studentsApproved = <StudentModel>[].obs;
  RxList<StudentModel> studentsPending = <StudentModel>[].obs;
  RxList<StudentModel> studentsAttendance = <StudentModel>[].obs;
  
  RxList<RecordedDanceClassModel> recordedClasses = <RecordedDanceClassModel>[].obs;

  void filterList(String query){

  }

  void addLiveDanceClass(LiveDanceClassModel liveDanceClass)async{
    print(Get.find<ImagePickerController>().imgPathDanceClass.value);
    final id = await DanceClassAPI.addDanceClass(liveDanceClass);
    await ImageCloudStorage.uploadDanceClassPicture(liveDanceClass.instructor.instructorId, id, File(Get.find<ImagePickerController>().imgPathDanceClass.value));
  }

  void addRecordedDanceClass(RecordedDanceClassModel recordedDanceClass)async{
    final id = await DanceClassAPI.addRecordedDanceClass(recordedDanceClass);
  }

  Future<bool> populateUpcomingClasses() async {
    bool hasFetched = false;
    print("in populate classes");
    upcomingDanceClasses.clear();
    try {
      final classes = await DanceClassAPI.getLiveDanceClasses();
      final upcoming = classes['upcoming_classes'];
      final done = classes['classes_done'];
      print("done ${done.toString()}");

      for(var upcomingClass in upcoming){
        LiveDanceClassModel upClass = LiveDanceClassModel.fromJson(upcomingClass);
        final isLikedValue = await LikeAPI.getLikeFromStudent(upClass.danceClassId, Get.find<AuthController>().currentUser.value!.studentId);
        // upClass.likes = await LikeAPI.getLikesOfDanceClass(upClass.danceClassId);
        final likesValue = await LikeAPI.getLikesOfDanceClass(upClass.danceClassId);
        upClass.likes = likesValue['result'];
        upClass.isLiked = isLikedValue['val'];
        upClass.img = await ImageCloudStorage.getDanceClassPicture(upClass.danceClassId);
        upClass.instructor.img = await ImageCloudStorage.getInstructorPicture(upClass.instructor.userId);
        upClass.instructor.profilePicture = await ImageCloudStorage.getProfilePicture(upClass.instructor.userId);
        print("rating  is ${upClass.instructor.rating}");
        upcomingDanceClasses.add(upClass);
      }

      for(var doneClass in done){
        LiveDanceClassModel doneTemp = LiveDanceClassModel.fromJson(doneClass);
        // doneTemp.likes = await LikeAPI.getLikesOfDanceClass(doneTemp.danceClassId);
        // doneTemp.isLiked = await LikeAPI.getLikeFromStudent(doneTemp.danceClassId, Get.find<AuthController>().currentUser.value!.studentId);
        doneTemp.img = await ImageCloudStorage.getDanceClassPicture(doneTemp.danceClassId);
        doneTemp.instructor.profilePicture = await ImageCloudStorage.getProfilePicture(doneTemp.instructor.userId);
        doneTemp.instructor.img = await ImageCloudStorage.getInstructorPicture(doneTemp.instructor.userId);
        doneDanceClasses.add(doneTemp);
      }
      hasFetched = true;
      await getRecordedDanceClasses();
      await Get.find<StudentController>().getStudentDanceClass();
      await Get.find<InstructorController>().getInstructors();
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

  Future<bool> getRecordedDanceClassStudents(int class_id) async {
    studentsApproved.clear();
    studentsPending.clear();
    try {
      final response = await DanceClassAPI.getLiveDanceClassStudents(class_id);
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

  Future<dynamic> generateQrAttendance(int classId)async{
    try {
      final response = await AttendanceAPI.generateQr(classId);
      return response['url'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> getStudentsAttended(int liveClassId, int live)async{
    studentsAttendance.clear();
    studentsApproved.clear();
    studentsPending.clear();
    await getLiveDanceClassStudents(liveClassId);
    try {
      final response = await DanceClassAPI.getStudentsAttended(live);
      for(final student in response){
        print(student);
        StudentModel stud = StudentModel.fromJson(student['student']);
        stud.profilePicture =  await ImageCloudStorage.getProfilePicture(stud.userId);

        studentsAttendance.add(stud);
      }
      return true;
    } catch (e) {
      throw Exception("error sa students attended controller");
    }
  }

  Future<bool> getRecordedDanceClasses() async {
    bool hasFetched = false;
    recordedClasses.clear();
    print("in get recorded classes");
    try{
      final recordings = await DanceClassAPI.getRecordedDanceClasses();
      for(var recording in recordings){
        print(recording.toString());
        RecordedDanceClassModel recordedClass = RecordedDanceClassModel.fromJson(recording);
        final isLikedValue = await LikeAPI.getLikeFromStudent(recordedClass.danceClassId, Get.find<AuthController>().currentUser.value!.studentId);
        final likesValue = await LikeAPI.getLikesOfDanceClass(recordedClass.danceClassId);
        recordedClass.likes = likesValue['result'];
        recordedClass.isLiked = isLikedValue['val'];
        // recordedClass.instructor.profilePicture = await ImageCloudStorage.getProfilePicture(recording.instructor.userId);
        // recordedClass.instructor.img = await ImageCloudStorage.getInstructorPicture(recordedClass.instructor.userId);

        recordedClasses.add(recordedClass);
      }
      hasFetched = true;
    } catch (e) {
      print("haha err");
      print(e);
    }
    return hasFetched;
  }

}