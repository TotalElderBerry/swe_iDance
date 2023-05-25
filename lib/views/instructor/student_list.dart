import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:skeletons/skeletons.dart';
import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../widgets/instructor/approved_widget.dart';
import '../../widgets/instructor/pending_widget.dart';
import '../../widgets/instructor/studentscancel_widget.dart';

class StudentListScreen extends StatelessWidget {
  LiveDanceClassModel liveDance;
  StudentListScreen(
      {super.key, required this.initIndex, required this.liveDance});
  final int initIndex;

  void filterItems(String query) {
    if (query.isNotEmpty) {
      List<PaymentStudent> students = [];
      List<PaymentStudent> students2 = [];
      final arr = Get.find<DanceClassController>().studentsPending;
      final arr2 = Get.find<DanceClassController>().studentsApproved;
      arr.forEach((item) {
        if (item.student.firstName
            .toLowerCase()
            .contains(query.toLowerCase())) {
          // tempList.add(item);
          students.add(item);
        }
      });
      Get.find<DanceClassController>().studentPendingSearched.clear();
      Get.find<DanceClassController>().studentPendingSearched.addAll(students);

      arr2.forEach((item) {
        if (item.student.firstName
            .toLowerCase()
            .contains(query.toLowerCase())) {
          // tempList.add(item);
          students2.add(item);
        }
      });
      Get.find<DanceClassController>().studentApprovedSearched.clear();
      Get.find<DanceClassController>()
          .studentApprovedSearched
          .addAll(students2);

      return;
    } else {
      Get.find<DanceClassController>().studentPendingSearched.clear();
      Get.find<DanceClassController>()
          .studentPendingSearched
          .addAll(Get.find<DanceClassController>().studentsPending);
      Get.find<DanceClassController>().studentApprovedSearched.clear();
      Get.find<DanceClassController>()
          .studentApprovedSearched
          .addAll(Get.find<DanceClassController>().studentsApproved);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initIndex,
      length: 3,
      child: RefreshIndicator(
        onRefresh: () async {
          Get.find<DanceClassController>()
              .getLiveDanceClassStudents(liveDance.danceClassId);
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [],
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          // TOFIXXXXX!!!
                          filterItems(val);
                        },
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
                      isScrollable: true,
                      tabs: [
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.pending_outlined),
                              Text("Pending",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.approval),
                              Text("Approved",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cancel),
                              Text("Cancel",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: Get.find<DanceClassController>()
                        .getLiveDanceClassStudents(liveDance.danceClassId),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: TabBarView(
                            children: [
                              PendingWidget(liveDance: liveDance),
                              ApprovedWidget(),
                              CancelWidget(liveDance: liveDance),
                            ],
                          ),
                        );
                      }
                      return Expanded(child: SkeletonListView());
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
