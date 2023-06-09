import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';

import '../../controllers/notification/notifcontroller.dart';

class InstructorNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
        future: Get.find<NotificationController>().getNotificationsOfUser(Get.find<AuthController>().currentInstructor.value!.userId,1),
        builder: (context, snapshot) {
          print(snapshot);
          if(snapshot.hasData){
          return Obx(() {
              // Get.find<NotificationController>().listenNotifications();

            Get.find<NotificationController>().newNotifications.value = 0;

                  // Get.find<NotificationController>().listenNotifications();
            return ListView.builder(
            itemCount: Get.find<NotificationController>().notifs.length, // Replace with the actual number of notifications
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  // Replace with the notification user's profile picture
                  child: notifIcon(Get.find<NotificationController>().notifs[index]),
                ),
                title: Text(
                  // Replace with the notification text
                  Get.find<NotificationController>().notifs[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  // Replace with the notification timestamp
                  '2 hours ago',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    // Add functionality for handling more options for each notification
                  },
                ),
                onTap: () {
                  // Add functionality to navigate to the relevant screen
                },
              );
            },
          );}
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        }
      ),
    );
  }
}

Widget notifIcon(String notif){
  if(notif.contains("cancel")){
    return Icon(Icons.cancel_rounded);
  }
  return Icon(Icons.book_online);
}