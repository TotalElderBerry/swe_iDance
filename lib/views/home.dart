import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/auth/login_page.dart';

import '../controllers/auth/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<AuthController>();
    String name = _auth.name.value;
    print('The current user main: ${_auth.currentUser.value}');

    return Scaffold(
      body: Column(children: [Text('Welcome student ${_auth.name.value} fuck u'),
        ElevatedButton(onPressed: (){
          AuthController controller = Get.find();
          controller.logout();
          print("logout");
          Get.to(LoginPage());
        }, child: Text("Logout"))
      ]),
    );
  }
}