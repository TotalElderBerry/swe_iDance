import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../controllers/student/student.dart';
import '../../models/attendance_model.dart';

class FullListWidget extends StatefulWidget {
  int liveClassId;
  FullListWidget({super.key, required this.liveClassId});

  @override
  State<FullListWidget> createState() => _FullListWidgetState();
}

class _FullListWidgetState extends State<FullListWidget> {
  @override
  Widget build(BuildContext context) {
    return attended.isEmpty
        ? Text('No data available.')
        : ListView.builder(
            itemCount: Get.find<DanceClassController>().studentsApproved.length,
            itemBuilder: (context, index) {
              bool isTrue = false;
              for(int i = 0; i < Get.find<DanceClassController>().studentsAttendance.length; i++){
                  if(Get.find<DanceClassController>().studentsAttendance[i].studentId == Get.find<DanceClassController>().studentsApproved[index].studentId){
                    isTrue = true;
                    break;
                  }
                // for(int j = 0; j < Get.find<DanceClassController>().studentsApproved.length; j++){
                // }
              }
              return Card(
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                         (
                            Get.find<DanceClassController>().studentsApproved[index].profilePicture == "")?
                            'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                            :
                            Get.find<DanceClassController>().studentsApproved[index].profilePicture!
                        ),
                    ),
                    title: Text("${Get.find<DanceClassController>().studentsApproved[index].firstName} ${Get.find<DanceClassController>().studentsApproved[index].lastName}"),
                    trailing: 
                    (isTrue == true)?
                    Text("Attended"):
                    ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Attend Student?"),
                              content: Text("Do you wish to attend ${Get.find<DanceClassController>().studentsApproved[index].firstName} ${Get.find<DanceClassController>().studentsApproved[index].lastName}"),
                              actions: [
                                TextButton(onPressed: ()async{
                                  await Get.find<StudentController>().attendDanceClass(Get.find<DanceClassController>().studentsApproved[index].studentId, widget.liveClassId);
                                  Navigator.of(context).pop();
                                  Get.find<DanceClassController>().studentsAttendance.add(Get.find<DanceClassController>().studentsApproved[index]);
                                }, child: Text("Yes")),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("No")),
                              ],
                            );
                          });
                      },
                      child: const Text('Attend'),
                    )),
              );
            },
          );
  }
}
