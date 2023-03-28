import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controllers/auth/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<AuthController>();
    String name = _auth.name.value;
    return Scaffold(
      body: Center(child: Text('Welcome $name')),
    );
  }
}