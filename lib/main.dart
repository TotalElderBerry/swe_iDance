import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/theme/theme.dart';
import 'package:i_dance/views/auth/login_page.dart';

void main() {
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
      home: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) => authController.isLoggedIn == true ? LoginPage() : LoginPage(),
      ),
    );
  }
}