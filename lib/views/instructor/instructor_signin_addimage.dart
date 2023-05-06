import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:i_dance/models/instructor.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/image/imagecontroller.dart';
import '../../models/student.dart';
import '../../sources/firebasestorage/firebase_storage.dart';
import 'instructor_home.dart';

class InstructorAddImage extends StatelessWidget {
  InstructorModel instructor;
  InstructorAddImage({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
             Text('Add Image to gain more Students',style: Theme.of(context).textTheme.headlineMedium),
                 const SizedBox(height: 5,),
                const SizedBox(height: 10,),
            Obx((){
                      if(Get.find<ImagePickerController>().instructorImagePath.value == ''){
                        return SizedBox(
                            child: IconButton(
                            onPressed: (){
                              Get.find<ImagePickerController>().pickImageForInstructor();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(Icons.camera_alt)),
                            width: (MediaQuery.of(context).size.width),
                            height: 150,
                          );
                      }else{
                        return GestureDetector(
                          onTap: () => Get.find<ImagePickerController>().pickImageForInstructor(),
                          onLongPress: () => Get.find<ImagePickerController>().instructorImagePath.value = '',
                          child: SizedBox(
                              child: Image.file(File(Get.find<ImagePickerController>().instructorImagePath.value),fit: BoxFit.cover,),
                              width: (MediaQuery.of(context).size.width),
                              height: 150,
                            ),
                        );
                      }
                    }
                  ),
                const Text('You can always skip this step',textAlign: TextAlign.center,),
                ElevatedButton(
                onPressed: ()async{
               
                  try {
                      await Get.find<InstructorController>().addInstructor(instructor).then((isSuccess){
                        if(isSuccess == true){
                          Get.find<AuthController>().currentInstructor.value = instructor;
                          Get.offAll(InstructorHome());
                        }
                      });
                  } catch (e) {
                    
                  }
                },
                child: Text('Register'),),
          ],
        ),
      ),
    );
  }
}