import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/theme/theme.dart';
import 'package:i_dance/views/auth/login_page.dart';
import 'package:i_dance/views/auth/register_page.dart';
import 'package:i_dance/views/auth/register_page2.dart';
import 'package:i_dance/views/home.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';
import 'package:i_dance/views/student/payment_success.dart';
import 'package:i_dance/views/student/student_home.dart';

import 'controllers/danceclass/danceclasscontroller.dart';
import 'controllers/instructor/instructor.dart';
import 'controllers/student/student.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final StudentController studentController = Get.put(StudentController());
    final DanceClassController danceClassController = Get.put(DanceClassController());
    final ImagePickerController imagePickerController = Get.put(ImagePickerController());
    final InstructorController instructorController = Get.put(InstructorController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.blue),
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
            labelMedium: TextStyle(fontWeight: FontWeight.bold)
          )
        ),
        // home: authController.isLoggedIn.value == true ? HomePage() : LoginPage(),
        home: 
             StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, snapshot) {
                return Obx((){
                  if (snapshot.hasData || Get.find<AuthController>().isLoggedIn.value) {
                    print("The current user");
                    print(FirebaseAuth.instance.currentUser);
                    return const StudentHomePage();
                  }
                  return const LoginPage();
                  

                });
              }
            ),
      );
  }
}