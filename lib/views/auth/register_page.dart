import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children:  [
          
          Text("Sign Up"),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your first name",
              labelText: "First Name"
            ),
          ), 
          
        ],
      
      ),
    );
  }
}