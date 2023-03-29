import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children:  [
          
          Image.network("https://dragonball.guru/wp-content/uploads/2021/01/goku-dragon-ball-guru-824x490.jpg"),
         Text("Welcome Back!"),
         TextField(
            decoration: InputDecoration(
              hintText: "Email",
              labelText: "FIrst EMail"
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          Divider(),
         ElevatedButton(onPressed: null, child: Text("Login")),
          TextButton(onPressed: (){}, child: Text("Register Now")),
        ],
      ),
    );
  }
}