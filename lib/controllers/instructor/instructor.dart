import 'dart:io';

import 'package:get/get.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/models/payment_details.dart';
import 'package:i_dance/sources/localstorage/localstorage.dart';

import '../../models/dance_class.dart';
import '../../models/instructor.dart';
import '../../models/recorded_dance_model.dart';
import '../../socket/socket.dart';
import '../../sources/api/dance-class/dance-class.dart';
import '../../sources/api/instructor/instructor.dart';
import '../../sources/api/like/like.dart';
import '../../sources/firebasestorage/firebase_storage.dart';

import '../../utils/getDaysBetween.dart';
import '../auth/auth_controller.dart';
import '../danceclass/danceclasscontroller.dart';

class InstructorController extends GetxController {
  RxList<LiveDanceClassModel> instructorDanceClass =
      <LiveDanceClassModel>[].obs;
  RxList<RecordedDanceClassModel> instructorRecordedDanceClass =
      <RecordedDanceClassModel>[].obs;
  RxList<InstructorModel> instructors = <InstructorModel>[].obs;

  RxList<LiveDanceClassModel> toShowList = <LiveDanceClassModel>[].obs;
  RxInt toShowLive = 0.obs;
  Future<bool> addInstructor(InstructorModel newInstructor) async {
    print(newInstructor.description);
    try {
      String token = await InstructorAPI.addInstructor(newInstructor);
      print(token);
      await ImageCloudStorage.uploadInstructorImage(newInstructor.userId,
          File(Get.find<ImagePickerController>().instructorImagePath.value));
      LocalStorageSource.writeToStorage('instructor_token', token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void socketAcceptStudent(LiveDanceClassModel liveClass, String user_id) {
    if (IDanceSocket.socket != null) {
      IDanceSocket.socket!.emit("accept_pending_student", {
        'user_id': user_id,
        'dance_class_name': liveClass.danceName,
        'type': 2,
        'msg': 'You are now enrolled in class ${liveClass.danceName}'
      });
    }
  }

  void socketAcceptCancelRequest(
      LiveDanceClassModel liveClass, String user_id) {
    if (IDanceSocket.socket != null) {
      IDanceSocket.socket!.emit("accept_cancellation_request", {
        'user_id': user_id,
        'dance_class_name': liveClass.danceName,
        'type': 2,
        'msg':
            'Your cancellation request of dance class ${liveClass.danceName} has been accepted.'
      });
    }
  }

  void socketRejectCancelRequest(
      LiveDanceClassModel liveClass, String user_id) {
    if (IDanceSocket.socket != null) {
      IDanceSocket.socket!.emit("reject_cancellation_request", {
        'user_id': user_id,
        'dance_class_name': liveClass.danceName,
        'type': 2,
        'msg':
            'Your cancellation request of dance class ${liveClass.danceName} has been rejected.'
      });
    }
  }

  List<LiveDanceClassModel> getUpcomingClasses() {
    List<LiveDanceClassModel> temp = [];
    for (int i = 0; i < instructorDanceClass.length; i++) {
      if (getDaysBetweenFromToday(instructorDanceClass[i].date) > 0) {
        temp.add(instructorDanceClass[i]);
      }
    }
    return temp;
  }

  List<LiveDanceClassModel> getDoneClasses() {
    List<LiveDanceClassModel> temp = [];
    for (int i = 0; i < instructorDanceClass.length; i++) {
      if (getDaysBetweenFromToday(instructorDanceClass[i].date) <= 0) {
        temp.add(instructorDanceClass[i]);
      }
    }
    return temp;
  }

  Future<bool> getLiveClassesOfInstructorbyId(
      InstructorModel instructor) async {
    print("get instructor");
    instructorDanceClass.clear();
    try {
      final response = await InstructorAPI.getLiveClassesOfInstructorbyId(
          instructor.instructorId);
      // LiveDanceClassModel ldance =LiveDanceClassModel.fromJson(response[0]);
      await getRecordedClassesOfInstructorbyId(instructor);

      for (int i = 0; i < response.length; i++) {
        print(response[i].toString());
        LiveDanceClassModel ldance = LiveDanceClassModel(
            int.parse(response[i]['live_danceclass_id']),
            date: response[i]['date'],
            location: response[i]['location'],
            studentLimit: int.parse(response[i]['student_limit']),
            danceClassId: int.parse(response[i]['dance_id']),
            danceName: response[i]['dance_name'],
            danceSong: response[i]['dance_song'],
            danceDifficulty: response[i]['dance_difficulty'],
            price: int.parse(response[i]['price']),
            description: response[i]['description'],
            payment: PaymentDetails.fromJson(response[i]['payment']),
            instructor: instructor);
        ldance.img =
            await ImageCloudStorage.getDanceClassPicture(ldance.danceClassId);
        final likesValue =
            await LikeAPI.getLikesOfDanceClass(ldance.danceClassId);
        ldance.likes = likesValue['result'];
        int ctr = 0;
        final resp =
            await DanceClassAPI.getLiveDanceClassStudents(ldance.danceClassId);
        for (var booked in resp) {
          // print(response['student']);
          if (booked['date_approved'] == 'PENDING') {
            ctr++;
          }
        }
        ldance.numOfPending = ctr;
        instructorDanceClass.add(ldance);
        toShowList.add(ldance);
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> getRecordedClassesOfInstructorbyId(
      InstructorModel instructor) async {
    print("get instructor");
    instructorRecordedDanceClass.clear();
    try {
      final response = await InstructorAPI.getRecordedDanceClassesOfInstructor(
          instructor.instructorId);
      // LiveDanceClassModel ldance =LiveDanceClassModel.fromJson(response[0]);

      for (int i = 0; i < response.length; i++) {
        print(response[i].toString());
        RecordedDanceClassModel recordedDanceClassModel =
            RecordedDanceClassModel(
          int.parse(response[i]['recorded_danceclass_id']),
          youtubeLink: response[i]['youtube_link'],
          danceClassId: int.parse(response[i]['dance_id']),
          danceName: response[i]['dance_name'],
          danceSong: response[i]['dance_song'],
          danceDifficulty: response[i]['dance_difficulty'],
          price: int.parse(response[i]['price']),
          description: response[i]['description'],
          payment: PaymentDetails.fromJson(response[i]['payment']),
          instructor: instructor,
        );
        print(recordedDanceClassModel.toJson().toString());
        instructorRecordedDanceClass.add(recordedDanceClassModel);
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> acceptStudentBooking(int studentId, int danceClassId) async {
    try {
      final response = await InstructorAPI.acceptStudentDanceBooking(
          studentId, danceClassId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectCancellationRequest(
      int studentId, int danceClassId) async {
    print(studentId);
    print(danceClassId);
    try {
      final response = await InstructorAPI.rejectCancellationRequest(
          studentId, danceClassId);
      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<bool> acceptCancellationRequest(
      int studentId, int danceClassId) async {
    try {
      final response = await InstructorAPI.acceptCancellationRequest(
          studentId, danceClassId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getInstructors() async {
    instructors.clear();
    try {
      final response = await InstructorAPI.getInstructors();
      for (int i = 0; i < response.length; i++) {
        // response[i]['instructor_id'] = "${response[i]['instructor_id']}";
        InstructorModel instructorModel = InstructorModel.fromJson(response[i]);
        instructorModel.profilePicture =
            await ImageCloudStorage.getProfilePicture(instructorModel.userId);
        instructors.add(instructorModel);
      }

      return true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
