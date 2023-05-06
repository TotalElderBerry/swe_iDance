import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';

import '../../models/student.dart';
import 'instructor_signin_addimage.dart';

class InstructorSignIn extends StatelessWidget {
  const InstructorSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController specialtyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: specialtyController,
              decoration: InputDecoration(
                labelText: 'Dance Specialty',
                hintText: 'Enter dance specialty',
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){
                StudentModel? current = Get.find<AuthController>().currentUser.value;
                InstructorModel newInstructor = InstructorModel(current!.userId, -1, firstName: current.firstName, lastName: current.lastName, gender: current.gender, contactNumber: current.contactNumber, emailAddress: current.emailAddress, dateOfBirth: current.dateOfBirth, rating: 0, description: descriptionController.text);
                try {
                    // bool isSuccess = await Get.find<InstructorController>().addInstructor(newInstructor);
                    // if(isSuccess == true) Get.offAll(InstructorHome());
                    Get.to(InstructorAddImage(instructor: newInstructor));
                } catch (e) {
                  
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

//rating
//description
//dance_specialty

