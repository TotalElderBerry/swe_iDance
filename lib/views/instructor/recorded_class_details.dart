import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/attendance.dart';
import 'package:i_dance/views/instructor/recorded_student_list.dart';
import 'package:i_dance/views/instructor/student_list.dart';

import '../../models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';

class RecordedClassDetails extends StatelessWidget {
  RecordedDanceClassModel recordedClass;
  RecordedClassDetails({super.key, required this.recordedClass});

  @override
  Widget build(BuildContext context) {
    String link = recordedClass.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Image.network(
                  // id!,
                  "https://img.youtube.com/vi/$id/0.jpg",
                  fit: BoxFit.fill,
                ),
              const SizedBox(
                height: 25,
              ),
              Text(recordedClass.danceName,style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.music_note,
                          color: Colors.white,
                        ),
                        label: Text(
                          recordedClass.danceSong,
                          style: TextStyle(color: Colors.white, fontSize: 11),
      
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.money,
                          color: Colors.white,
                        ),
                        label: Text(
                          "${recordedClass.price}",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.pending_outlined),
                            iconSize: 30,
                            onPressed: () => Get.to(RecordedStudentList(
                              initIndex: 0,
                              recordedDanceClassModel: recordedClass,
                            )),
                          ),
                          Text("Pending"),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.approval),
                            iconSize: 30,
                            onPressed: () => Get.to(RecordedStudentList(
                              initIndex: 1,
                              recordedDanceClassModel: recordedClass,
                            )),
                          ),
                          Text("Approved"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Description:",
                  ),
                  Text(
                    "Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
