import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/home.dart';
import 'package:i_dance/widgets/my_appbar.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/image/imagecontroller.dart';
import '../../models/student.dart';
import 'home_screen.dart';

class EditStudentProfile extends StatefulWidget {
  const EditStudentProfile({super.key});

  @override
  State<EditStudentProfile> createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
   TextEditingController _emailController = TextEditingController();
   TextEditingController lastNameController = TextEditingController();
   TextEditingController firstNameController = TextEditingController();
   TextEditingController contactNumberController = TextEditingController();
   TextEditingController birthDateController = TextEditingController();
  bool isEasy = true;
  bool isMedium = false;
  bool isHard = false;
  String url = "https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg";


  @override
  Widget build(BuildContext context) {
    StudentModel? currentStudent = Get.find<AuthController>().currentUser.value;
    _emailController.text = currentStudent!.emailAddress;
    lastNameController.text = currentStudent!.lastName;
    firstNameController.text = currentStudent!.firstName;
    contactNumberController.text = currentStudent!.contactNumber;
    birthDateController.text = currentStudent!.dateOfBirth.toString().split(" ")[0];
    String level = "Beginner";

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Update',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          content: const Text(
            'Are you sure you want to update?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          backgroundColor: const Color(0xFFede9f7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF5f527e),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Color(0xFF5f527e),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                StudentModel updatedStudent = StudentModel(Get.find<AuthController>().currentUser.value!.studentId, Get.find<AuthController>().currentUser.value!.userId, firstName: firstNameController.text, lastName: lastNameController.text, gender: "M", contactNumber: contactNumberController.text, emailAddress: _emailController.text, dateOfBirth: DateTime.utc(2001,06,14), level: level, isInstructor: Get.find<AuthController>().currentUser.value!.isInstructor);
                await Get.find<AuthController>().updateStudent(updatedStudent);
                Get.offAll(HomeScreen());
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Update your profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () => Get.find<ImagePickerController>().pickImage(),
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Obx(() {
                      return Expanded(
                        child:
                            Get.find<ImagePickerController>().imgPath.value ==
                                    ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                                    // backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                                  ),
                                  )
                                : 
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                  File(Get.find<ImagePickerController>().imgPath.value),
                                  fit: BoxFit.cover,
                                ),
                              )
                      );
                    })),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: "Enter your first name",
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: "Enter your last name",
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: contactNumberController,
                decoration: const InputDecoration(
                  hintText: "Enter your contact number",
                  labelText: "Contact Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: birthDateController,
                decoration: const InputDecoration(
                  hintText: "Enter your birthdate",
                  labelText: "Birthdate",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Enter your email address",
                  labelText: "Email address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Skill Level',
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEasy = true;
                          isMedium = false;
                          level = "Beginner";
                          isHard = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: isEasy == true ? Colors.purple : Colors.white,
                          border: Border.all(
                            color: Colors.purple,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Easy',
                          style: TextStyle(
                              color:
                                  isEasy == true ? Colors.white : Colors.black),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEasy = false;
                          isMedium = true;
                          level = "Intermediate";
                          isHard = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color:
                              isMedium == true ? Colors.purple : Colors.white,
                          border: Border.all(
                            color: Colors.purple,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Medium',
                          style: TextStyle(
                              color: isMedium == true
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEasy = false;
                          isMedium = false;
                          isHard = true;
                          level = "Advanced";
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: isHard == true ? Colors.purple : Colors.white,
                          border: Border.all(
                            color: Colors.purple,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Hard',
                          style: TextStyle(
                              color:
                                  isHard == true ? Colors.white : Colors.black),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 75,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
