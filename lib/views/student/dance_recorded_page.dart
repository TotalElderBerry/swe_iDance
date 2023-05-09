import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/views/student/student_profile.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/student/recorded_class_card.dart';

class ClassRecordedPage extends StatelessWidget {
  const ClassRecordedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leadingWidth: 76.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(StudentProfilePage());
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage((Get.find<AuthController>()
                  .authService
                  .getUser()!
                  .photoURL ==
                  null)
                  ? 'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'
                  : Get.find<AuthController>().authService.getUser()!.photoURL!),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StudentClassRecordedCard(fromPage: "",image: "https://i.ytimg.com/vi/MhaH4XkHK5A/maxresdefault.jpg", id: 0),
            StudentClassRecordedCard(fromPage: "",image: "https://i.ytimg.com/vi/7eLdG8tRgO4/maxresdefault.jpg", id: 1)
          ],
        ),
      ),
    );
  }
}
