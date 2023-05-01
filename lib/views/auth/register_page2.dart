import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/views/student/student_home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth/auth_controller.dart';



class RegisterPage2 extends StatefulWidget {
  final firstName;
  final lastName;
  final contactNumber;
  final birthdate;
  final email;
  final password;
  const RegisterPage2(this.firstName, this.lastName, this.contactNumber, this.birthdate, this.email, this.password,{Key? key}) : super(key: key);

  @override
  _RegisterPage2 createState() => _RegisterPage2();
}
class _RegisterPage2 extends State<RegisterPage2> {
  String _selectedSkillLevel = '';
  File? _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
              ],
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Get.find<ImagePickerController>().pickImage(),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
              child: 
              Obx((){
                return Expanded(
                  child: Get.find<ImagePickerController>().imgPath.value != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(
                            Get.find<ImagePickerController>().imgPath.value,   
                          )
                          ),
                        ):
                    Center(
                        child: 
                        Icon(
                          Icons.camera_alt,
                          ),
                        ),
                );
              })
                    ),
            ),
          SizedBox(height: 16),
          Text(
            'What is your skill level?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSkillLevel = 'Beginner';
                  });
                },
                child: Text(
                  'Beginner',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSkillLevel = 'Intermediate';
                  });
                },
                child: const Text(
                  'Intermediate',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSkillLevel = 'Expert';
                  });
                },
                child: const Text(
                  'Expert',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$_selectedSkillLevel',
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              print("register");
              StudentModel student = StudentModel(1,"0",firstName: widget.firstName, lastName: widget.lastName, gender: "C", contactNumber: widget.contactNumber, emailAddress: widget.email, dateOfBirth: DateTime.utc(2001,06,14), level: _selectedSkillLevel, isInstructor: 0);
              print(student.firstName);
              bool isSuccess= await Get.find<AuthController>().register(student, widget.password);
              if(isSuccess){
                Get.find<AuthController>().isLoggedIn.value = true;
                Get.offAll(StudentHomePage());
              }
            },
            child: const  Text('Register'),
          ),
        ],
      ),
    );
  }
}
