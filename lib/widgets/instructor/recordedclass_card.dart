import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/models/recorded_dance_model.dart';

import '../../views/instructor/recorded_class_details.dart';
import '../../views/student/dance_class_details.dart';
import '../../views/student/dance_class_recorded_details.dart';
import '../../views/student/student_home_live.dart';

class InstructorRecordedClassCard extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  InstructorRecordedClassCard({super.key, required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          RecordedClassDetails(
            recordedClass: recordedDanceClassModel
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width) - 32,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                     "https://img.youtube.com/vi/${
                    RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+").firstMatch(recordedDanceClassModel.youtubeLink)!.group(0)!
                     }/0.jpg",
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.video_camera_front_outlined, size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Recorded Class',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          recordedDanceClassModel.danceName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(
                                 recordedDanceClassModel.instructor.profilePicture!),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${recordedDanceClassModel.instructor.firstName} ${recordedDanceClassModel.instructor.lastName}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                   
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
