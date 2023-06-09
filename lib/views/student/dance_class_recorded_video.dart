import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/attendance_model.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../models/recorded_dance_model.dart';


class DanceClassRecordedVideo extends StatefulWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  DanceClassRecordedVideo({required this.recordedDanceClassModel, Key? key}) : super(key: key);


  @override
  State<DanceClassRecordedVideo> createState() => _DanceClassRecordedVideoState();
}

class _DanceClassRecordedVideoState extends State<DanceClassRecordedVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    String link = widget.recordedDanceClassModel.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: id!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    super.initState();
  }


  Widget build(BuildContext context) {
    String link = widget.recordedDanceClassModel.youtubeLink;
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child:  YoutubePlayer(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  )
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse(widget.recordedDanceClassModel.youtubeLink)),
                          child: 
                            Text(
                              widget.recordedDanceClassModel.youtubeLink,
                              style: TextStyle(
                                color: Colors.blue
                              )
                            ),
                          
                        )
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




