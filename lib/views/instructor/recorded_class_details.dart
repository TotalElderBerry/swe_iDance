import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/recorded_student_list.dart';

import '../../models/recorded_dance_model.dart';
import 'edit_recorded_class_page.dart';

class RecordedClassDetails extends StatelessWidget {
  RecordedDanceClassModel recordedClass;

  RecordedClassDetails({Key? key, required this.recordedClass}) : super(key: key);

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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tagIcon,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            tagText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String link = recordedClass.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Add your edit functionality here
              Get.to(EditRecordedClassPage());
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              "https://img.youtube.com/vi/$id/0.jpg",
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    recordedClass.danceName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDifficultyTag(recordedClass.danceDifficulty),
                      Text(
                        "Price: \$${recordedClass.price}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Get.to(RecordedStudentList(
                          initIndex: 0,
                          recordedDanceClassModel: recordedClass,
                        )),
                        icon: Icon(Icons.pending_outlined),
                        label: Text("Pending"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Get.to(RecordedStudentList(
                          initIndex: 1,
                          recordedDanceClassModel: recordedClass,
                        )),
                        icon: Icon(Icons.approval),
                        label: Text("Approved"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Description:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
