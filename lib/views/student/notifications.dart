import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';

import '../../controllers/notification/notifcontroller.dart';

class StudentNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
        future: Get.find<NotificationController>().getNotificationsOfUser(Get.find<AuthController>().currentInstructor.value!.userId,2),
        builder: (context, snapshot) {
          print(snapshot);
          if(snapshot.hasData){
          return Obx(() {
                  // Get.find<NotificationController>().listenNotifications();
            return ListView.builder(
            itemCount: Get.find<NotificationController>().notifs.length, // Replace with the actual number of notifications
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  // Replace with the notification user's profile picture
                  child: Icon(Icons.check_outlined),
                ),
                title: Text(
                  // Replace with the notification text
                  Get.find<NotificationController>().notifs[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  // Replace with the notification timestamp
                  '2 hours ago',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        }
      ),
    );
  }
}
