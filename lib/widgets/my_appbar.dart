import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controllers/auth/auth_controller.dart';
import '../controllers/student/student.dart';
import '../models/instructor.dart';
import '../views/instructor/instructor_home.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  BuildContext parentContext;
  MyAppBar(this.parentContext,{super.key});

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
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () async {
                  //  try {
                  //   InstructorModel? instructorModel = await Get.find<StudentController>().switchToInstructor();
                  //   print("instructor is");
                  //   print(instructorModel);
                  //   if(instructorModel == null){
                  //     print("unauthorized");
                  //   }else{
                  //     print("authorized");
                  //     Get.to(InstructorHome());
                  //   }
                  // } catch (e) {
                  //   print(e);                  
                  // }
                      Get.to(InstructorHome());

                },
                icon: Icon(Icons.school),
                label: Text('Switch to Student'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {
                  Get.find<AuthController>().logout();
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
    return AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leadingWidth: 76.0,
        leading: IconButton(onPressed: () {
            _showBottomSheet(context);
        }, icon: const Icon(Icons.menu)),
        actions: [
          CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                      ),
        ],
      );

  }
      @override
      Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}