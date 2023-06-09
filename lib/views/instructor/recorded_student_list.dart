import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/recorded_dance_model.dart';
import '../../widgets/instructor/approved_widget.dart';
import '../../widgets/instructor/pending_widget.dart';
import '../../widgets/instructor/recorded_pending_widget.dart';

class RecordedStudentList extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  RecordedStudentList({super.key, required this.initIndex, required this.recordedDanceClassModel});
  final int initIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
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
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.pending_outlined),
                            Text("Pending",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.approval),
                            Text("Approved",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FutureBuilder(
                future: Get.find<DanceClassController>().getRecordedDanceClassStudents(recordedDanceClassModel.danceClassId),
                builder: ((context, snapshot) {
                  if(snapshot.hasData){

                    return Expanded(
                      child: TabBarView(
                        children: [
                          RecordedPendingWidget(recordedClass: recordedDanceClassModel),
                          ApprovedWidget(),
                        ],
                      ),
                    );
                  }
                  return Text("Loading");
                  
              })),
            ],
          ),
        ),
      ),
    );
  }
}
