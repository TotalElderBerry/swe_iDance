import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/theme/theme.dart';
import 'package:i_dance/views/auth/login_page.dart';
import 'package:i_dance/views/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());


    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme
      ),
      home: 
      Obx((){
        if(Get.find<AuthController>().isLoggedIn.value){
          return HomePage();
        }
        return LoginPage();
        // return (authController.isLoggedIn.value == true)? HomePage():LoginPage();
      })
      // authController.isLoggedIn.value == true ? LoginPage() : LoginPage(),
    );
  }
}