import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import '../../models/attendance_model.dart';

class AttendedWidget extends StatefulWidget {
  const AttendedWidget({super.key});

  @override
  State<AttendedWidget> createState() => _AttendedWidgetState();
}

class _AttendedWidgetState extends State<AttendedWidget> {
  @override
  Widget build(BuildContext context) {
    return Get.find<DanceClassController>().studentsAttendance.isEmpty
        ? Text('No data available.')
        : ListView.builder(
            itemCount: Get.find<DanceClassController>().studentsAttendance.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                         (
                            Get.find<DanceClassController>().studentsAttendance[index].profilePicture == "")?
                            'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                            :
                            Get.find<DanceClassController>().studentsAttendance[index].profilePicture!
                        ),
                    ),
                    title: Text("${Get.find<DanceClassController>().studentsAttendance[index].firstName} ${Get.find<DanceClassController>().studentsAttendance[index].lastName}"),
                  trailing: Text(attended[index]["Date"]),
                ),
              );
            },
          );
  }
}
