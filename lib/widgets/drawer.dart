import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/views/student/home_screen.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../views/instructor/instructor_home.dart';
import '../../views/instructor/instructor_signin.dart';
import '../../views/student/edit_student_profile.dart';
import '../views/auth/login_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD6B0FF),
                  Color(0xFF8E7CE7),
                ],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
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
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Hello, ${Get.find<AuthController>().currentUser.value!.firstName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.to(HomeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () {
              Get.to(EditStudentProfile());
            },
          ),
          Obx(() {
            return ListTile(
              leading: const Icon(Icons.school),
              title: Text(
                  Get.find<AuthController>().currentInstructor.value == null
                      ? 'Become an Instructor'
                      : 'Switch to Instructor'),
              onTap: () async {
                if (Get.find<AuthController>().currentInstructor.value ==
                    null) {
                  Get.to(InstructorSignIn());
                } else {
                  Get.offAll(InstructorHome());
                }
              },
            );
          }),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Get.find<AuthController>().logout();
              Get.offAll(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
