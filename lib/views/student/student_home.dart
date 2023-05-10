import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';
import 'package:i_dance/views/student/dance_class_details.dart';
import 'package:i_dance/widgets/student/dance_class_card.dart';
import 'package:i_dance/widgets/my_appbar.dart';
import 'package:i_dance/widgets/student/student_class_card.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Get.find<AuthController>().getLoggedStudent(),
          builder: (context, snapshot) {
            if(snapshot.hasData){  
              print(snapshot.data);
              return Column(
                
                children: [
                  
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: Get.find<DanceClassController>().populateUpcomingClasses(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        print(Get.find<DanceClassController>().upcomingDanceClasses);
                        if(Get.find<DanceClassController>().upcomingDanceClasses.isEmpty){
                          return Text("Empty");
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: Get.find<DanceClassController>().upcomingDanceClasses.length,
                            itemBuilder: (context, idx){
                                return DanceClassCard(liveClass: Get.find<DanceClassController>().upcomingDanceClasses.elementAt(idx));
                            }
                          ),
                        );
                      }
                    return Text("loading");
                    }
                  ),
                ],
              );
            }
            return Text("Loading pa");
          }
        ),
      ),
    );
  }
}
