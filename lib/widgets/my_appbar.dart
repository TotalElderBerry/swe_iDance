import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/notification/notifcontroller.dart';
import 'package:i_dance/socket/socket.dart';
import 'package:i_dance/views/instructor/instructor_profile.dart';

import '../controllers/auth/auth_controller.dart';
import '../controllers/student/student.dart';
import '../models/instructor.dart';
import '../views/auth/login_page.dart';
import '../views/instructor/instructor_home.dart';
import '../views/instructor/instructor_signin.dart';
import '../views/student/edit_student_profile.dart';
import '../views/student/notifications.dart';
import '../views/student/student_profile.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  BuildContext parentContext;
  String? title;

  MyAppBar(this.parentContext, this.title, {super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {
                  Get.to(InstructorHome());
                },
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {
                  Get.to(EditStudentProfile());
                },
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
              ),
              Divider(),
              Obx(() {
                return TextButton.icon(
                  onPressed: () async {
                    if (Get.find<AuthController>().currentInstructor.value ==
                        null) {
                      Get.to(InstructorSignIn());
                    } else {
                      Get.offAll(InstructorHome());
                    }
                  },
                  icon: Icon(Icons.school),
                  label: Text(
                      (Get.find<AuthController>().currentInstructor.value ==
                              null)
                          ? 'Become an Instructor'
                          : 'Switch to Instructor'),
                );
              }),
              Divider(),
              TextButton.icon(
                onPressed: () async {
                  await Get.find<AuthController>().logout();
                  Get.offAll(LoginPage());
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MenuController menuController = MenuController();

    return AppBar(
        title: Text(title!),
        scrolledUnderElevation: 0,
        elevation: 0,
        // leadingWidth: 8.0,
        leading: IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: const Icon(Icons.menu)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(StudentNotification());
                    },
                    icon: Icon(Icons.notifications)),
                Positioned(
                  left: 25,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 8,
                    child: Obx(() {
                      Get.find<NotificationController>().listenNotifications();

                      return Text(
                        Get.find<NotificationController>()
                            .newNotifications
                            .value
                            .toString(),
                        style: TextStyle(fontSize: 8),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(StudentProfilePage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage((Get.find<AuthController>()
                            .authService
                            .getUser()!
                            .photoURL ==
                        null)
                    ? 'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                    : Get.find<AuthController>()
                        .authService
                        .getUser()!
                        .photoURL!),
                // backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
              ),
            ),
          ),
        ]);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
