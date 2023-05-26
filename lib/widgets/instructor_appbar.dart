import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/student_home.dart';

import '../controllers/auth/auth_controller.dart';
import '../controllers/notification/notifcontroller.dart';
import '../views/auth/login_page.dart';
import '../views/instructor/edit_instructor_profile.dart';
import '../views/instructor/instructor_home.dart';
import '../views/instructor/instructor_profile.dart';
import '../views/instructor/notifications.dart';
import '../views/student/home_screen.dart';
import '../views/student/student_profile.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({required this.parentContext,required this.title,required this.scaffoldKey, Key? key}) : super(key: key);


  final BuildContext parentContext;
  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {

    MenuController menuController = MenuController();

    return AppBar(
        title: Text(widget.title!),
        scrolledUnderElevation: 0,
        elevation: 0,
        // leadingWidth: 8.0,
        leading: IconButton(
            onPressed: () {
              print("Drawer Opened");
              widget.scaffoldKey.currentState?.openDrawer();
            }, icon: const Icon(Icons.menu)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Stack(
              children: [
                IconButton(onPressed: (){
                  Get.to(InstructorNotification());
                }, icon: Icon(Icons.notifications)),
                Positioned(
                  left: 25,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 8,
                    child: Obx(() =>  Text(Get.find<NotificationController>().newNotifications.value.toString(), style: TextStyle(fontSize: 8),)),

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
                backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                // backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
              ),
            ),
          ),
        ]
    );

  }

}







// class InstructorAppBar extends StatelessWidget implements PreferredSizeWidget {
//   BuildContext parentContext;

//   InstructorAppBar(this.parentContext, {super.key});

//   void showInstructorBottomSheet(BuildContext ctx) {
//     showModalBottomSheet(
//       context: ctx,
//       builder: (BuildContext ctx) {
//         return Container(
//           height: 250,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16.0),
//               topRight: Radius.circular(16.0),
//             ),
//             border: Border.all(
//               color: Colors.grey.shade400,
//               width: 1,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextButton.icon(
//                 onPressed: () {
//                   Get.offAll(InstructorHome());
//                 },
//                 icon: Icon(Icons.home),
//                 label: Text('Home'),
//               ),
//               Divider(),
//               TextButton.icon(
//                 onPressed: () {
//                   Get.to(EditInstructorProfile());
//                 },
//                 icon: Icon(Icons.edit),
//                 label: Text('Edit Profile'),
//               ),
//               Divider(),
//               TextButton.icon(
//                 onPressed: () {
//                   Get.offAll(HomeScreen());
//                 },
//                 icon: Icon(Icons.school),
//                 label: Text('Switch to Student'),
//               ),
//               Divider(),
//               TextButton.icon(
//                 onPressed: () async {
//                   await Get.find<AuthController>().logout();
//                   Get.offAll(LoginPage());
//                 },
//                 icon: Icon(Icons.logout),
//                 label: Text('Logout'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext ctx) {
//     MenuController menuController = MenuController();

//     return AppBar(
//       scrolledUnderElevation: 0,
//       elevation: 0,
//       leadingWidth: 76.0,
//       leading: IconButton(
//           onPressed: () {
//             showInstructorBottomSheet(ctx);
//           },
//           icon: const Icon(Icons.menu)),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0),
//           child: Stack(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     Get.to(InstructorNotification());
//                     Get.find<NotificationController>().newNotifications.value = 0;

//                   },
//                   icon: Icon(Icons.notifications)),
//               Positioned(
//                 left: 25,
//                 top: 10,
//                 child: CircleAvatar(
//                     backgroundColor: Colors.yellow,
//                     radius: 8,
//                     child: Obx(() {
//                       Get.find<NotificationController>().listenNotifications();

//                       return Text(
//                         Get.find<NotificationController>()
//                             .newNotifications
//                             .value
//                             .toString(),
//                         style: TextStyle(fontSize: 8),
//                       );
//                     })),
//               )
//             ],
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Get.to(InstructorProfilePage());
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage: NetworkImage((Get.find<AuthController>()
//                           .authService
//                           .getUser()!
//                           .photoURL ==
//                       null)
//                   ? 'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
//                   : Get.find<AuthController>()
//                       .authService
//                       .getUser()!
//                       .photoURL!),
//               // backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => new Size.fromHeight(kToolbarHeight);
// }
