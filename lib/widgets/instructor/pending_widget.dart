import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/studentlist_model.dart';
import '../../sources/firebasestorage/firebase_storage.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
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
                            Get.find<DanceClassController>().studentsPending[index].profilePicture == "")?
                            'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                            :
                            Get.find<DanceClassController>().studentsPending[index].profilePicture!
                        ),
                  ),
                  title: Text("${Get.find<DanceClassController>().studentsPending[index].firstName} ${Get.find<DanceClassController>().studentsPending[index].lastName}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            DateTime now = DateTime.now();
                            String dateFormat =
                                DateFormat('yyyy-MM-dd - hh:mm').format(now);
                            approvedAttend.add({
                              "Name": pendingAttend.elementAt(index).toString(),
                              "Date": dateFormat,
                            });
                            pendingAttend.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            pendingAttend.removeAt(index);
                          });
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
