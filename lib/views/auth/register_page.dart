import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/views/auth/register_page2.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Color.fromARGB(255, 242, 103, 39), // Set the desired color
                  fontSize: 24, // Set the desired font size
                  fontWeight: FontWeight.bold, // Set the desired font weight
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your first name",
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your last name",
                        labelText: "Last Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: contactNumberController,
                      decoration: InputDecoration(
                        hintText: "Enter contact number",
                        labelText: "Contact Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your contact number";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: birthDateController,
                      decoration: InputDecoration(
                        hintText: "Enter Birthdate",
                        labelText: "Birthdate",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your birthdate";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email address";
                  }
                  // Check if the email address is valid
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle gesture here
                },
                child: Text(
                  "Sign In Instead",
                  style: TextStyle(
                    color: Color.fromARGB(255, 242, 103, 39),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 242, 103, 39),
                  ),  
                ),
              ),
              SizedBox(width: 20),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    
                  }
                  Get.to(RegisterPage2(firstNameController.text,lastNameController.text,contactNumberController.text,birthDateController.text,_emailController.text,passwordController.text));
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color of the button
  ),
                child: Text("Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Set the desired font size
                  fontWeight: FontWeight.bold, // Set the desired font weight
                ),
              ),
              ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
} 
