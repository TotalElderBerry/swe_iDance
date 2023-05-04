import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/attendance_model.dart';

class FullListWidget extends StatefulWidget {
  const FullListWidget({super.key});

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
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Attend'),
                    )),
              );
            },
          );
  }
}
