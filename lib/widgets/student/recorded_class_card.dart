import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/models/recorded_dance_model.dart';

import '../../views/student/dance_class_details.dart';
import '../../views/student/dance_class_recorded_details.dart';
import '../../views/student/student_home_live.dart';

class StudentClassRecordedCard extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  StudentClassRecordedCard({super.key, required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          DanceClassRecordedDetails(
            recordedDanceClassModel: recordedDanceClassModel
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width) - 70,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const SizedBox(width: 10,),
                                _buildDifficultyTag(recordedDanceClassModel.danceDifficulty)
                          ],
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

  Widget _buildDifficultyTag(String difficulty) {
    Color tagColor;
    String tagText;
    IconData tagIcon;

    switch (difficulty) {
      case "Easy":
      case "Beginner":
        tagColor = Colors.green;
        tagText = "Beginner";
        tagIcon = Icons.accessible;
        break;
      case "Intermediate":
      case "Medium":
        tagColor = Colors.orange;
        tagText = "Intermediate";
        tagIcon = Icons.timeline;
        break;
      case "Advanced":
      case "Hard":
        tagColor = Colors.red;
        tagText = "Advanced";
        tagIcon = Icons.whatshot;
        break;
      default:
        tagColor = Colors.grey;
        tagText = "N/A";
        tagIcon = Icons.help;
        break;
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              tagIcon,
              size: 12,
              color: Colors.white,
            ),
            SizedBox(width: 2),
            Text(
              tagText,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  }}
