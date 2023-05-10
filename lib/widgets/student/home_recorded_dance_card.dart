import 'package:flutter/material.dart';
import 'package:i_dance/views/student/recorded_dance_class_booking.dart';

import '../../models/live_dance_class.dart';
import '../../models/recorded_dance_model.dart';

class HomeRecordedDanceCard extends StatelessWidget {
  RecordedDanceClassModel recordedClass;
  HomeRecordedDanceCard({
    super.key,
    required this.recordedClass
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 210,
          child: Column(
            children: [
              Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: 
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                     "https://img.youtube.com/vi/${
                    RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+").firstMatch(recordedClass.youtubeLink)!.group(0)!
                     }/0.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // height: 80,
                  ),
                ),
                
                // Image.network(
                //   'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          recordedClass.instructor.profilePicture!,
                        ),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${recordedClass.instructor.firstName} ${recordedClass.instructor.lastName}",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  // const Icon(
                  //   Icons.favorite,
                  //   color: Colors.red,
                  // ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    recordedClass.danceName,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}