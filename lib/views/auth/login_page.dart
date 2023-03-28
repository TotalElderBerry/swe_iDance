import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Column(
              children: [
                Text("Login"),
              ],
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username"
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                ),
              ],
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Forgot Password")
                  ],
                ),
                ElevatedButton(onPressed: (){
                  Get.find<AuthController>().login("test@gmail.com","test");
                }, child: Text("Login"))
          ],
        ),
      )
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(

    );
  }
}