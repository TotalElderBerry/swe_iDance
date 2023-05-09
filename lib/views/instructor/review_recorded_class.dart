import 'dart:convert';

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
  RecordedDanceClassModel recordedDanceClass;
  ReviewRecordedClass({super.key, required this.recordedDanceClass});

  @override
  Widget build(BuildContext context) {
    String link = recordedDanceClass.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);
    print(id!);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            print(recordedDanceClass.toJson().toString());
            Get.find<DanceClassController>().addRecordedDanceClass(recordedDanceClass);
            Get.offAll(InstructorHome());

          },
          child: const Center(
            child: Text('Create Dance'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  // id!,
                  "https://img.youtube.com/vi/$id/0.jpg",
                  fit: BoxFit.fill,
                ),
                Text(
                  recordedDanceClass.danceName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.music_note,
                          color: Colors.purple,
                        ),
                        Text(recordedDanceClass.danceSong),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          color: Colors.purple,
                        ),
                        Text(recordedDanceClass.danceDifficulty),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.money,
                          color: Colors.purple,
                        ),
                        Text('${recordedDanceClass.price}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.link,
                          color: Colors.purple,
                        ),
                        TextButton(
                          onPressed: () => launchUrl(
                            Uri.parse(recordedDanceClass.youtubeLink),
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(recordedDanceClass.youtubeLink),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                ),
                ListTile(
                  leading: Text('Full Name'),
                  title: Text(recordedDanceClass.payment.accountName),
                ),
                ListTile(
                  leading: Text('Reference Number'),
                  title: Text(recordedDanceClass.payment.accountNumber),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Dance Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(recordedDanceClass.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
