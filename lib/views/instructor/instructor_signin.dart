import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:i_dance/controllers/image/imagecontroller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/models/student.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';

class InstructorSignIn extends StatefulWidget {
  const InstructorSignIn({Key? key}) : super(key: key);

  @override
  _InstructorSignInState createState() => _InstructorSignInState();
}

class _InstructorSignInState extends State<InstructorSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _specialtyController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      StudentModel? current = Get.find<AuthController>().currentUser.value;
      InstructorModel newInstructor = InstructorModel(
        current!.userId,
        -1,
        firstName: current.firstName,
        lastName: current.lastName,
        gender: current.gender,
        contactNumber: current.contactNumber,
        emailAddress: current.emailAddress,
        dateOfBirth: current.dateOfBirth,
        rating: 0,
        description: _descriptionController.text,
      );
      try {
        await Get.find<InstructorController>().addInstructor(newInstructor).then((isSuccess) {
          if (isSuccess == true) {
            Get.find<AuthController>().currentInstructor.value = newInstructor;
            Get.offAll(InstructorHome());
          }
        });
      } catch (e) {
        // Display error message
        Get.snackbar(
          'Error',
          'An error occurred while signing in.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please select a timeline photo',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              width: double.infinity,
              height: 150,
              child: Obx(
                () {
                  if (Get.find<ImagePickerController>().instructorImagePath.value == '') {
                    return IconButton(
                      onPressed: () {
                        Get.find<ImagePickerController>().pickImageForInstructor();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.camera_alt),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => Get.find<ImagePickerController>().pickImageForInstructor(),
                      onLongPress: () => Get.find<ImagePickerController>().instructorImagePath.value = '',
                      child: Image.file(
                        File(Get.find<ImagePickerController>().instructorImagePath.value),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: null, // Allow the text field to dynamically adjust its height
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description.';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16), // Adjust the font size as needed
                        textInputAction: TextInputAction.newline, // Enable new line input
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _specialtyController,
                        decoration: InputDecoration(
                          labelText: 'Dance Specialty',
                          hintText: 'Enter dance specialty',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a dance specialty.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
