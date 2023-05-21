import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';
import '../../views/student/dance_class_details.dart';
import '../../views/student/students_class_details.dart';

class StudentRecordedClassCard extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  bool isPending;
  StudentRecordedClassCard({super.key, required this.isPending, required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   StudentDanceClassDetails(
        //     recordedDanceClassModel: recordedDanceClassModel,
        //     isPending: isPending,
        //   ),
        // );
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
                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Recorded Class",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
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