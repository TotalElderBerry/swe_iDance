import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/studentlist_model.dart';

class ApprovedWidget extends StatefulWidget {
  const ApprovedWidget({super.key});

  @override
  State<ApprovedWidget> createState() => _ApprovedWidgetState();
}

class _ApprovedWidgetState extends State<ApprovedWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
        return Get.find<DanceClassController>().studentsApproved.isEmpty
        ? const Text('No data available.')
        : ListView.builder(
            itemCount: Get.find<DanceClassController>().studentsApproved.length,
            itemBuilder: (context, index) {
            
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
                ),
              );
            },
          );
      });
    
  
  }
}
