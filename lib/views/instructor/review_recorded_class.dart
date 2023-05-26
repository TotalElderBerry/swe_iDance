import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/generateRefNumber.dart';
import '../student/pay_page.dart';
import 'package:http/http.dart' as http;

import 'instructor_home.dart';

class ReviewRecordedClass extends StatelessWidget {
  final RecordedDanceClassModel recordedDanceClass;

  ReviewRecordedClass({Key? key, required this.recordedDanceClass})
      : super(key: key);

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
    String link = recordedDanceClass.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);
    print(id!);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                "https://img.youtube.com/vi/$id/0.jpg",
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recordedDanceClass.danceName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  _buildDifficultyTag(
                    recordedDanceClass.danceDifficulty,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor: Colors.purple,
                    label: Text(
                      recordedDanceClass.danceSong,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: Colors.purple,
                    label: Text(
                      '\$${recordedDanceClass.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.link,
                    color: Colors.purple,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => launchUrl(
                        Uri.parse(recordedDanceClass.youtubeLink),
                        mode: LaunchMode.externalApplication,
                      ),
                      child: Text(
                        recordedDanceClass.youtubeLink,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Details",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                    ),
                    title: Text("PayMaya"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "Account Name: ${recordedDanceClass.payment.accountName}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Account Number: ${recordedDanceClass.payment.accountNumber}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dance Description",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recordedDanceClass.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  print(recordedDanceClass.toJson().toString());
                  Get.find<DanceClassController>()
                      .addRecordedDanceClass(recordedDanceClass);
                  Get.offAll(InstructorHome());
                },
                child: const Text('Create Dance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
