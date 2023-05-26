import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/student/student.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/student/dance_class_card.dart';
import '../../widgets/student/student_bookedrecordedclass_card.dart';
import '../../widgets/student/student_class_card.dart';
import '../../widgets/student/student_recordedclass_card.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage((Get.find<AuthController>()
                              .authService
                              .getUser()!
                              .photoURL ==
                          null)
                      ? 'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                      : Get.find<AuthController>()
                          .authService
                          .getUser()!
                          .photoURL!),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "${Get.find<AuthController>().currentUser.value!.firstName} ${Get.find<AuthController>().currentUser.value!.lastName}",
                        style: Theme.of(context).textTheme.labelLarge),
                    Chip(
                        label: Text("Beginner"),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            VisualDensity(horizontal: 0.0, vertical: -4)),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.translate(
                offset: const Offset(-40, 0),
                child: Obx(
                  () {
                    return DropdownButton(
                      value: (Get.find<StudentController>().isLivePanel.value ==
                              true)
                          ? 1
                          : 2,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("Live Classes"),
                        ),
                        DropdownMenuItem(
                          child: Text("Recorded Classes"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        if (value == 1) {
                          Get.find<StudentController>().isLivePanel.value =
                              true;
                          // Get.find<StudentController>().isPending.value = false;
                          // Get.find<StudentController>().isDone.value = false;
                          // Get.find<StudentController>().isLiked.value = false;
                        }
                        if (value == 2) {
                          Get.find<StudentController>().isLivePanel.value =
                              false;
                          // Get.find<StudentController>().isPending.value = false;
                        }
                      },
                    );
                  },
                )),
          ),
          Expanded(
            child: Obx(() {
              return (Get.find<StudentController>().isLivePanel.value == true)
                  ? liveClassTab(context)
                  : recordedClassTab(context);
            }),
          )
        ],
      ),
    );
  }

  Widget liveClassTab(BuildContext context) {
    Get.find<StudentController>().filteredBookingClass.value =
        Get.find<StudentController>().getBookedClasses();

    return Obx(() => DefaultTabController(
          initialIndex:
              Get.find<StudentController>().isLivePanel.value == true ? 0 : 0,
          length: 4,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  onTap: (int indx) {
                    if (indx == 0) {
                      Get.find<StudentController>().filteredBookingClass.value =
                          Get.find<StudentController>().getBookedClasses();
                      Get.find<StudentController>().isPending.value = false;
                      Get.find<StudentController>().isDone.value = false;
                      Get.find<StudentController>().isLiked.value = false;
                    } else if (indx == 1) {
                      Get.find<StudentController>().isLiked.value = false;
                      Get.find<StudentController>().filteredBookingClass.value =
                          Get.find<StudentController>().getPendingClasses();
                      Get.find<StudentController>().isPending.value = true;
                      Get.find<StudentController>().isDone.value = false;
                      print(
                          "length is ${Get.find<StudentController>().filteredBookingClass.length}");
                    } else if (indx == 2) {
                      Get.find<StudentController>().isLiked.value = false;
                      Get.find<StudentController>().filteredBookingClass.value =
                          Get.find<StudentController>().getDoneClasses();
                      Get.find<StudentController>().isDone.value = true;
                    } else {
                      Get.find<StudentController>().isLiked.value = true;

                      Get.find<StudentController>()
                          .filteredBookingClass
                          .clear();
                    }
                  },
                  tabs: [
                    Tab(
                      icon: Text("Upcoming",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Tab(
                      icon: Text("Pending",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Tab(
                      icon: Text("Done",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Tab(
                      icon: Text("Likes",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ]),
              SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {
                  if (Get.find<StudentController>().isLiked.value == true) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount:
                              Get.find<StudentController>().likedClasses.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StudentClassCard(
                                    isPending: Get.find<StudentController>()
                                        .isPending
                                        .value,
                                    isCancelled: false,
                                    liveDance: Get.find<StudentController>()
                                        .likedClasses[index])
                              ],
                            );
                          }),
                    );
                  }
                  if (Get.find<StudentController>()
                      .filteredBookingClass
                      .isEmpty) {
                    return Text("Empty");
                  }
                  return ListView.builder(
                      itemCount: Get.find<StudentController>()
                          .filteredBookingClass
                          .length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StudentClassCard(
                                isPending: Get.find<StudentController>()
                                    .isPending
                                    .value,
                                isCancelled: (Get.find<StudentController>()
                                            .filteredBookingClass[index]
                                            .dateApproved ==
                                        'PENDING'
                                    ? false
                                    : true),
                                liveDance: Get.find<StudentController>()
                                    .filteredBookingClass[index]
                                    .liveDanceClass!)
                          ],
                        );
                      });
                }),
              ),
            ],
          ),
        ));
  }

  Widget recordedClassTab(BuildContext context) {
    Get.find<StudentController>().filteredRecordedBookingClass.value =
        Get.find<StudentController>().getBookedRecordingClasses();
    return Column(
      children: [
        DefaultTabController(
          length: 3,
          child: TabBar(
              isScrollable: true,
              onTap: (int indx) {
                print(indx);
                if (indx == 0) {
                  Get.find<StudentController>().isRecordingPending.value =
                      false;
                  Get.find<StudentController>().isRecordingBooked.value = true;
                  Get.find<StudentController>().isRecordingLiked.value = false;
                  Get.find<StudentController>()
                          .filteredRecordedBookingClass
                          .value =
                      Get.find<StudentController>().getBookedRecordingClasses();
                } else if (indx == 1) {
                  Get.find<StudentController>().isRecordingBooked.value = false;
                  Get.find<StudentController>().isRecordingPending.value = true;
                  Get.find<StudentController>().isRecordingLiked.value = false;
                  Get.find<StudentController>()
                          .filteredRecordedBookingClass
                          .value =
                      Get.find<StudentController>().getPendingRecordedClasses();
                  print(
                      "length ${Get.find<StudentController>().filteredRecordedBookingClass.length}");
                } else if (indx == 2) {
                  Get.find<StudentController>().isRecordingBooked.value = false;
                  Get.find<StudentController>().isRecordingPending.value =
                      false;
                  Get.find<StudentController>().isRecordingLiked.value = true;
                }
              },
              tabs: [
                Tab(
                  icon: Text("Classes",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Tab(
                  icon: Text("Pending",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Tab(
                  icon: Text("Likes",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ]),
        ),
        SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Obx(() {
            if (Get.find<StudentController>().isRecordingLiked.value == true) {
              return Expanded(
                child: ListView.builder(
                    itemCount: Get.find<StudentController>()
                        .likedRecordedClasses
                        .length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StudentRecordedClassCard(
                              isPending:
                                  Get.find<StudentController>().isPending.value,
                              recordedDanceClassModel:
                                  Get.find<StudentController>()
                                      .likedRecordedClasses[index])
                        ],
                      );
                    }),
              );
            }
            if (Get.find<StudentController>()
                .filteredRecordedBookingClass
                .isEmpty) {
              return Text("Empty");
            }
            return ListView.builder(
                itemCount: Get.find<StudentController>()
                    .filteredRecordedBookingClass
                    .length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StudentBookedRecordedClassCard(
                          isPending: Get.find<StudentController>()
                              .isRecordingPending
                              .value,
                          recordedDanceClassModel: Get.find<StudentController>()
                              .filteredRecordedBookingClass[index]
                              .recordedDanceClass!)
                    ],
                  );
                  // }
                });
          }),
        ),
      ],
    );
  }
}
