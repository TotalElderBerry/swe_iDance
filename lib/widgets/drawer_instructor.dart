import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/views/instructor/edit_instructor_profile.dart';
import 'package:i_dance/views/student/home_screen.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../views/instructor/instructor_home.dart';
import '../../views/instructor/instructor_signin.dart';
import '../../views/student/edit_student_profile.dart';


class Drawer_Instructor extends StatefulWidget {
  const Drawer_Instructor({Key? key}) : super(key: key);

  @override
  State<Drawer_Instructor> createState() => _Drawer_InstructorState();
}

class _Drawer_InstructorState extends State<Drawer_Instructor> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
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
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/placeholder.png'),
                ),
                SizedBox(width: 20,),
                Text(
                  'Hello, User',
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
              Get.to(InstructorHome());
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () {
              Get.to(EditInstructorProfile());
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Switch to Student'),
            onTap: () {
              Get.to(HomeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Get.find<AuthController>().logout();
            },
          ),
        ],
      ),
    );
  }
}
