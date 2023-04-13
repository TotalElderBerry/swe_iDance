import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/student.dart';
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.school),
                label: Text('Switch to Instructor'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/w3images/avatar2.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => ImagePicker().pickImage(source: ImageSource.gallery),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(image: FileImage(_image!), fit: BoxFit.cover),
                      ):
                  Center(
                      child: 
                      Icon(
                        Icons.camera_alt,
                        ),
                      ),
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
                child: Text(
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
                child: Text(
                  'Expert',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '$_selectedSkillLevel',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print("register");
              StudentModel student = StudentModel(1,"0",firstName: widget.firstName, lastName: widget.lastName, gender: "C", contactNumber: widget.contactNumber, emailAddress: widget.email, dateOfBirth: DateTime.utc(2001,06,14), level: _selectedSkillLevel, isInstructor: 0);

              Get.find<AuthController>().register(student, widget.password);
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
