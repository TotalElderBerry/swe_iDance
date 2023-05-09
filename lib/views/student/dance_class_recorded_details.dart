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


class DanceClassRecordedDetails extends StatefulWidget {
   DanceClassRecordedDetails({required this.fromPage, required this.danceId, Key? key}) : super(key: key);

  String fromPage;
  int danceId;

  @override
  State<DanceClassRecordedDetails> createState() => _DanceClassRecordedDetailsState();
}

class _DanceClassRecordedDetailsState extends State<DanceClassRecordedDetails> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: recordedDance[widget.danceId]['link'].toString().split("v=")[1],
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    super.initState();
  }


  Widget build(BuildContext context) {
    String link = recordedDance[widget.danceId]['link'];
    RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: widget.fromPage == "CardUpcoming"
            ? ElevatedButton(
          onPressed: () async {
            String COLOR_CODE = '#ffffff';
            String CANCEL_BUTTON_TEXT = 'CANCEL';
            bool isShowFlashIcon = true;
            ScanMode scanMode = ScanMode.DEFAULT;
            String qr = await FlutterBarcodeScanner.scanBarcode(
              COLOR_CODE,
              CANCEL_BUTTON_TEXT,
              isShowFlashIcon,
              scanMode,
            );
            attended.add(
              {
                "Name": "Jose Cruz",
                "Date": "2023-04-21 - 05:57",
              },
            );
            // ignore: use_build_context_synchronously
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Qr Scanned Successfully!',
            );
          },
          child: const Center(
            child: Text('Attendance'),
          ),
        )
            : widget.fromPage == "CardPending"
            ? ElevatedButton(
          onPressed: () {},
          child: const Center(
            child: Text('Cancel'),
          ),
        )
            : widget.fromPage == "StudentHomeLive"
            ? ElevatedButton(
          onPressed: () => Get.to(AddPaymentPage()),
          child: const Center(
            child: Text('Book Dance Class'),
          ),
        ) : widget.fromPage == "StudentRecordedLive" ?
             ElevatedButton(
          onPressed: () => Get.to(AddPaymentPage()),
          child: const Center(
            child: Text('Buy Dance Class'),
          ),
        ) : SizedBox()
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: widget.fromPage == "StudentRecordedLive" ?
                  Image.network(
                    'https://i.ytimg.com/vi/$id/maxresdefault.jpg',
                    fit: BoxFit.contain,
                    height: 200,
                  ) :
                  YoutubePlayer(
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
                          recordedDance[widget.danceId]['song'],
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
                    widget.fromPage == "StudentRecordedLive" ?
                    const SizedBox(
                      height: 10,
                    ) : SizedBox(height: 0,),


                    widget.fromPage == "StudentRecordedLive" ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              size: 24,
                              Icons.calendar_month,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "March 12,2023",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              size: 24,
                              Icons.access_time,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "12:00 PM",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              size: 24,
                              Icons.money,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              recordedDance[widget.danceId]['price'],
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Spacer(),

                      ],
                    ) : SizedBox(height: 0,),

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
                              'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Roger Intong",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      recordedDance[widget.danceId]['details'],
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




