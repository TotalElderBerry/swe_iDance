import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:intl/intl.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/live_dance_class.dart';
import '../../models/student.dart';
import '../../models/studentlist_model.dart';
import '../../sources/firebasestorage/firebase_storage.dart';


class PendingWidget extends StatelessWidget {
  LiveDanceClassModel liveDance;
  PendingWidget({super.key, required this.liveDance});
  
  @override
  Widget build(BuildContext context) {
    return 
      Obx((){
        return Get.find<DanceClassController>().studentsPending.isEmpty
        ? const Text('No data available.')
        : ListView.builder(
            itemCount: Get.find<DanceClassController>().studentsPending.length,
            itemBuilder: (context, index) {
            
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                         (
                            Get.find<DanceClassController>().studentsPending[index].student.profilePicture == "")?
                            'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                            :
                            Get.find<DanceClassController>().studentsPending[index].student.profilePicture!
                        ),
                  ),
                  title: Text("${Get.find<DanceClassController>().studentsPending[index].student.firstName} ${Get.find<DanceClassController>().studentsPending[index].student.lastName}"),
                  subtitle: Text(Get.find<DanceClassController>().studentsPending[index].referenceModel),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          
                          
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Accept Student?"),
                              content: Text("Do you wish to accept the payment of ${Get.find<DanceClassController>().studentsPending[index].student.firstName} ${Get.find<DanceClassController>().studentsPending[index].student.lastName}"),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.find<InstructorController>().acceptStudentBooking(Get.find<DanceClassController>().studentsPending[index].student.studentId, liveDance.danceClassId);
                                  PaymentStudent temp = Get.find<DanceClassController>().studentsPending[index];

                                  Get.find<DanceClassController>().studentsPending.removeAt(index);
                                  Get.find<DanceClassController>().studentsApproved.add(temp);
                                  Navigator.of(context).pop();

                                }, child: Text("Yes")),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("No")),
                              ],
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Delete Student?"),
                              content: Text("Do you wish to remove the booking of ${Get.find<DanceClassController>().studentsPending[index].student.firstName} ${Get.find<DanceClassController>().studentsPending[index].student.lastName}"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();

                                }, child: Text("Yes")),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("No")),
                              ],
                            );
                          });
                          // setState(() {
                          //   //here
                          //   pendingAttend.removeAt(index);
                          // });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
      });
    
  }
}
