import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/attendance_model.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';
import 'package:i_dance/views/student/recorded_class_payment.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/student/student.dart';
import '../../models/recorded_dance_model.dart';

class DanceClassRecordedDetails extends StatefulWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  DanceClassRecordedDetails({super.key,required this.recordedDanceClassModel});

  @override
  State<DanceClassRecordedDetails> createState() => _DanceClassRecordedDetailsState();
}

class _DanceClassRecordedDetailsState extends State<DanceClassRecordedDetails> {
  @override
  Widget build(BuildContext context) {
    String link = widget.recordedDanceClassModel.youtubeLink;
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
            Get.to(RecordedClassPaymentPage(recordedDanceClassModel: widget.recordedDanceClassModel));
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
                          widget.recordedDanceClassModel.danceName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildDifficultyTag(widget.recordedDanceClassModel.danceDifficulty),
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
                          children: [
                            Icon(
                              size: 24,
                              Icons.money,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "${widget.recordedDanceClassModel.price}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                            IconButton(onPressed: ()async{
                                setState(() {
                                  if(widget.recordedDanceClassModel.isLiked == 0){
                                    widget.recordedDanceClassModel.isLiked = 1;
                                    Get.find<StudentController>().likedRecordedClasses.add(widget.recordedDanceClassModel);
                                  }else{
                                    // Get.find<StudentController>().likedRecordedClasses.remove(widget.recordedDanceClassModel);
                                    widget.recordedDanceClassModel.isLiked = 0;
                                  }
                                //  widget.recordedDanceClassModel.isLiked = !widget.recordedDanceClassModel.isLiked; 
                                });

                                  await Get.find<StudentController>().likeDanceClass(widget.recordedDanceClassModel.danceClassId);
                              }, icon: 
                              (widget.recordedDanceClassModel.isLiked == 0)?
                              Icon(Icons.favorite_outline, color: Colors.red,)
                              :
                              Icon(Icons.favorite, color: Colors.red,)
                              )
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
                              widget.recordedDanceClassModel.instructor.profilePicture!),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.recordedDanceClassModel.instructor.firstName} ${widget.recordedDanceClassModel.instructor.lastName}",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.recordedDanceClassModel.description,
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


  Widget _buildDifficultyTag(String difficulty) {
    Color tagColor;
    String tagText;

    switch (difficulty) {
      case "Easy":
        tagColor = Colors.green;
        tagText = "Easy";
        break;
      case "Medium":
        tagColor = Colors.orange;
        tagText = "Intermediate";
        break;
      case "Hard":
        tagColor = Colors.red;
        tagText = "Advanced";
        break;
      default:
        tagColor = Colors.grey;
        tagText = "N/A";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tagText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }