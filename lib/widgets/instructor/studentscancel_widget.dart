import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:intl/intl.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../controllers/notification/notifcontroller.dart';
import '../../models/live_dance_class.dart';
import '../../models/student.dart';
import '../../models/studentlist_model.dart';
import '../../sources/firebasestorage/firebase_storage.dart';

class CancelWidget extends StatelessWidget {
  LiveDanceClassModel liveDance;
  CancelWidget({super.key, required this.liveDance});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<DanceClassController>().studentsCancel.isEmpty
          ? Center(child: const Text('No data available.'))
          : ListView.builder(
              itemCount: Get.find<DanceClassController>().studentsCancel.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage((Get.find<
                                      DanceClassController>()
                                  .studentsCancel[index]
                                  .student
                                  .profilePicture ==
                              "")
                          ? 'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                          : Get.find<DanceClassController>()
                              .studentsCancel[index]
                              .student
                              .profilePicture!),
                    ),
                    title: Text(
                        "${Get.find<DanceClassController>().studentsCancel[index].student.firstName} ${Get.find<DanceClassController>().studentsCancel[index].student.lastName}"),
                    subtitle: Text(Get.find<DanceClassController>()
                        .studentsCancel[index]
                        .referenceModel),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Accept Cancel Request?"),
                                    content: Text(
                                        "Do you wish to accept the cancellation request of ${Get.find<DanceClassController>().studentsCancel[index].student.firstName} ${Get.find<DanceClassController>().studentsCancel[index].student.lastName}. Note: Please refund"),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await Get.find<
                                                    InstructorController>()
                                                .acceptCancellationRequest(
                                                    Get.find<
                                                            DanceClassController>()
                                                        .studentsCancel[index]
                                                        .student
                                                        .studentId,
                                                    liveDance.danceClassId);

                                            PaymentStudent temp =
                                                Get.find<DanceClassController>()
                                                    .studentsCancel[index];

                                            Get.find<DanceClassController>()
                                                .studentsCancel
                                                .removeAt(index);

                                            Get.find<InstructorController>()
                                                .socketAcceptCancelRequest(
                                                    liveDance,
                                                    Get.find<
                                                            DanceClassController>()
                                                        .studentsCancel[index]
                                                        .student
                                                        .userId);

                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No")),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Reject Cancel Request?"),
                                    content: Text(
                                        "Do you wish to reject the cancel request of ${Get.find<DanceClassController>().studentsCancel[index].student.firstName} ${Get.find<DanceClassController>().studentsCancel[index].student.lastName}"),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            print(
                                                Get.find<DanceClassController>()
                                                    .studentsCancel
                                                    .length);
                                            print(
                                                "class id is ${Get.find<DanceClassController>().studentsCancel[index].student.studentId} and student id is ${liveDance.danceClassId}");
                                            await Get.find<
                                                    InstructorController>()
                                                .rejectCancellationRequest(
                                                    Get.find<
                                                            DanceClassController>()
                                                        .studentsCancel[index]
                                                        .student
                                                        .studentId,
                                                    liveDance.danceClassId);
                                            PaymentStudent temp =
                                                Get.find<DanceClassController>()
                                                    .studentsCancel[index];
                                            Get.find<DanceClassController>()
                                                .studentsCancel
                                                .removeAt(index);
                                            Get.find<DanceClassController>()
                                                .studentsPending
                                                .add(temp);
                                            Get.find<DanceClassController>()
                                                .studentPendingSearched
                                                .add(temp);

                                            // Get.find<InstructorController>()
                                            //     .socketRejectCancelRequest(
                                            //         liveDance,
                                            //         Get.find<
                                            //                 DanceClassController>()
                                            //             .studentsCancel[index]
                                            //             .student
                                            //             .userId);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No")),
                                    ],
                                  );
                                });
                            // setState(() {
                            //   //here
                            //   pendingAttend.removeAt(index);
                            // });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
