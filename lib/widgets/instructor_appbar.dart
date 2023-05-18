import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/student_home.dart';

import '../controllers/auth/auth_controller.dart';
import '../controllers/notification/notifcontroller.dart';
import '../views/instructor/instructor_home.dart';
import '../views/instructor/instructor_profile.dart';
import '../views/student/home_screen.dart';
import '../views/student/student_profile.dart';

class InstructorAppBar extends StatelessWidget implements PreferredSizeWidget{
  BuildContext parentContext;

  InstructorAppBar(this.parentContext,{super.key});

   void showInstructorBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext ctx) {
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
                  Get.offAll(InstructorHome());
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
                onPressed: () {
                  Get.offAll(HomeScreen());
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
  Widget build(BuildContext ctx) {
    MenuController menuController = MenuController();

    return AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leadingWidth: 76.0,
        leading: IconButton(onPressed: () {
            showInstructorBottomSheet(ctx);
        }, icon: const Icon(Icons.menu)),
        actions: [
          Obx((){ 
            return MenuAnchor(
            child: Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: IconButton(onPressed: (){
                  menuController.open();
                }, icon: Icon(Icons.notifications)),
              ),
            controller: menuController,
            menuChildren: Get.find<NotificationController>().notifs.map(
              (element) => MenuItemButton(child: Text(element))
            ).toList(),
            // menuChildren: [
            //   // ListView.builder(
            //   //   itemCount: Get.find<NotificationController>().notifs.length,
            //   //   itemBuilder: (context,index){
            //   //     return MenuItemButton(child: Text(Get.find<NotificationController>().notifs[index]));
            //   // })

            //   // for (int i = 0; i < Get.find<NotificationController>().notifs.length; i++) {
            //   //   MenuItemButton(child: Text(Get.find<NotificationController>().notifs[index]));
            //   // }

            // ], 
          );
          }),

          GestureDetector(
            onTap: () {
              Get.to(InstructorProfilePage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                // backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
              ),
            ),
          ),
        ],
      );

  }
      @override
      Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}