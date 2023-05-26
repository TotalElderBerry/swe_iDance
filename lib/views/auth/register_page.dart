import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/views/auth/register_page2.dart';

import '../../theme/theme.dart';

class DateController extends GetxController{
  Rx<DateTime?> dateSelected = null.obs;
}

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
  Widget build(BuildContext cont){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Create your Account",
                  style: TextStyle(
                    color:lightColorScheme.primary,
                    fontSize: 24, // Set the desired font size
                    fontWeight: FontWeight.bold, // Set the desired font weight
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter your first name",
                          labelText: "First Name",
                          border: OutlineInputBorder(),
                          isDense: true
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your first name";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter your last name",
                          labelText: "Last Name",
                          border: OutlineInputBorder(),
                          isDense: true
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Contact number",
                          labelText: "Contact Number",
                          border: OutlineInputBorder(),
                          isDense: true
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your contact number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: birthDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: "Birthdate",
                          labelText: "Birthdate",
                          border: const OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: cont,
                                initialDate: DateTime(2000), // Refer step 1
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null) {
                            birthDateController.text = picked.toString().split(' ')[0];
                          }
                            },
                            icon: const Icon(Icons.calendar_month),
                          )
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    labelText: "Email Address",
                    border: OutlineInputBorder(),
                    isDense: true
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
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    isDense: true
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle gesture here
                  },
                  child: const Text(
                    "Sign In Instead",
                    style: TextStyle(
                      color: Color.fromARGB(255, 242, 103, 39),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 242, 103, 39),
                    ),  
                  ),
                ),
                const SizedBox(width: 20),
                
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(RegisterPage2(firstNameController.text,lastNameController.text,contactNumberController.text,birthDateController.text,_emailController.text,passwordController.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set the background color of the button
          ),
                  child: const Text("Next",
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
        ),
      );
  }
} 
