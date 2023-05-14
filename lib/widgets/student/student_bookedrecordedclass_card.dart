import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';
import '../../views/student/dance_class_details.dart';
import '../../views/student/dance_class_recorded_video.dart';
import '../../views/student/students_class_details.dart';

class StudentBookedRecordedClassCard extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  StudentBookedRecordedClassCard({super.key, required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          DanceClassRecordedVideo(
            recordedDanceClassModel: recordedDanceClassModel
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width) - 52,
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
                     width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(
                          label: Row(
                            children: [
                              const Icon(
                                Icons.video_camera_front_rounded,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Recorded Class',
                                style: Theme.of(context).textTheme.labelSmall,
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
                              '${recordedDanceClassModel.instructor.firstName} ${recordedDanceClassModel.instructor.lastName}',
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