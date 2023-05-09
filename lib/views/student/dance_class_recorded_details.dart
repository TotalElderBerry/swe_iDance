import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/attendance_model.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';
import 'package:i_dance/views/student/recorded_class_payment.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/recorded_dance_model.dart';

class DanceClassRecordedDetails extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  DanceClassRecordedDetails({super.key,required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    String link = recordedDanceClassModel.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: (){
            Get.to(RecordedClassPaymentPage(recordedDanceClassModel: recordedDanceClassModel));
          },
          child: Center(
            child: Text('Buy Dance Class'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  'https://i.ytimg.com/vi/$id/0.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          recordedDanceClassModel.danceSong,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       size: 24,
                    //       Icons.location_on,
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //     Text(
                    //       " UC Main Campus",
                    //       style: Theme.of(context).textTheme.labelSmall,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                          
                            Row(
                              children: [
                                Icon(
                                  size: 24,
                                  Icons.money,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "${recordedDanceClassModel.price}",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.link,
                    //       color: Colors.purple,
                    //     ),
                    //     TextButton(
                    //       onPressed: () => launchUrl(
                    //         Uri.parse(
                    //             'https://' + recordedDance[danceId]['link']),
                    //         mode: LaunchMode.externalApplication,
                    //       ),
                    //       child: Text(recordedDance[danceId]['link']),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              recordedDanceClassModel.instructor.profilePicture!),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${recordedDanceClassModel.instructor.firstName} ${recordedDanceClassModel.instructor.lastName}",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      recordedDanceClassModel.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
