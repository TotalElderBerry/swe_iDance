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

class StudentRecordedHomePage extends StatelessWidget {
  const StudentRecordedHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
                
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
                    future: Get.find<DanceClassController>().getRecordedDanceClasses(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(Get.find<DanceClassController>().recordedClasses.isEmpty){
                          return Text("Empty");
                        }
                        
                        return Expanded(
                          child: ListView.builder(
                            itemCount: Get.find<DanceClassController>().upcomingDanceClasses.length,
                            itemBuilder: (context, idx){
                              print(Get.find<StudentController>().isBookedClasses(Get.find<DanceClassController>().upcomingDanceClasses[idx].danceClassId));
                                return DanceClassCard(liveClass: Get.find<DanceClassController>().upcomingDanceClasses.elementAt(idx));
                            }
                          ),
                        );
                      }
                    return Text("loading");
                    }
                  ),
                ],
              )
            
          
        
      ),
    );
  }
}
