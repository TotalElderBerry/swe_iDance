import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/auth/register_page.dart';
import 'package:i_dance/views/home.dart';

import '../../controllers/auth/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
      final _auth = Get.find<AuthController>();
    String name = _auth.name.value;
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Column(

        children:  [
          Text('${name}'),
          Image.network("https://dragonball.guru/wp-content/uploads/2021/01/goku-dragon-ball-guru-824x490.jpg"),
         Text("Welcome Back!"),
         TextField(
          controller: userController,
            decoration: InputDecoration(
              hintText: "Email",
              labelText: "FIrst EMail"
            ),
          ),
          TextField(

            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          Divider(),
         ElevatedButton(onPressed: () async {
          AuthController authController = Get.find();
          if(authController.name.value == null){
            print('The current user: ${authController.currentUser.value}');
          }else{
            print('The current user: ${authController.currentUser.value}');

          }
          bool isSuccess = await authController.login(userController.text, passwordController.text);
          print(isSuccess);
          if(isSuccess) Get.to(HomePage());
         }, child: Text("Login")),
          TextButton(onPressed: (){
            Get.to(RegisterPage());
          }, child: Text("Register Now")),
        ],
      ),
    );
  }
}