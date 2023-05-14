import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:quickalert/quickalert.dart';

import '../../models/live_dance_class.dart';
import '../../widgets/instructor/attended_widget.dart';
import '../../widgets/instructor/fulllist_widget.dart';

class AttendanceScreen extends StatelessWidget {
  LiveDanceClassModel liveDance;
  AttendanceScreen({super.key, required this.liveDance});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  final qrLink = await Get.find<DanceClassController>().generateQrAttendance(liveDance.danceClassId);
                  // print(qrLink);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.custom,
                    widget: 
                    Image.memory(Base64Decoder().convert(qrLink.split(',').last)),
                    customAsset: null,
                  );
                  
                } catch (e) {
                  print(e);
                  // QuickAlert.show(
                  //   context: context,
                  //   type: QuickAlertType.custom,
                  //   widget: 
                  //   Image.memory(Base64Decoder().convert(qrLink)),
                  //   customAsset: null,
                  // );
                }
              },
              icon: const Icon(Icons.qr_code),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Text("Attended",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Tab(
                        icon: Text("Full List",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: Get.find<DanceClassController>().getStudentsAttended(liveDance.danceClassId,liveDance.liveClassId),
                builder: ((context, snapshot) {
                  if(snapshot.hasData){

                    return Expanded(
                        child: TabBarView(children: [
                          AttendedWidget(),
                          FullListWidget(liveClassId: liveDance.danceClassId),
                        ]),
                      );
                  }
                  return Text("Loading");
                  
              })),
              // const Expanded(
              //   child: TabBarView(children: [
              //     AttendedWidget(),
              //     FullListWidget(),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
 