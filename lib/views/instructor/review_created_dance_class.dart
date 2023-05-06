import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/sources/firebasestorage/firebase_storage.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../controllers/image/imagecontroller.dart';
import '../../models/live_dance_class.dart';

class ReviewDanceClassPage extends StatelessWidget {
  LiveDanceClassModel danceClass;
  ReviewDanceClassPage({super.key, required this.danceClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            try {
            Get.find<DanceClassController>().addLiveDanceClass(danceClass);
            ImageCloudStorage.uploadDanceClassPicture(danceClass.instructor.instructorId, danceClass.danceClassId, File(Get.find<ImagePickerController>().imgPathDanceClass.value));
              Get.offAll(InstructorHome());
            } catch (e) {
              throw Exception(e);
            }
          },
          child: const Center(
            child: Text('Create Dance Class'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            children: [
               ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.file(File((Get.find<ImagePickerController>().imgPathDanceClass.value)),
                  fit: BoxFit.contain,
                  height: 200,
                  ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(danceClass.danceName, style: Theme.of(context).textTheme.headlineLarge,),
                    
                      ],
                    ),
              
                      Row(
                          children: [
                            Icon(size: 24, Icons.location_on,color: Theme.of(context).primaryColor,),
                            Text(danceClass.location, style: Theme.of(context).textTheme.labelSmall,),
                          ],
                      ),
              
                      const SizedBox(height: 10,),
              
                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                              children: [
                                Row(
                                  children: [
                                    Icon(size: 24, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                    Text(danceClass.date, style: Theme.of(context).textTheme.labelSmall,),
                                  ],
                                ),
                                const SizedBox(width:15,),
              
                                Row(
                                    children: [
                                      Icon(size: 24, Icons.access_time,color: Theme.of(context).primaryColor,),
                                      Text("12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                                const SizedBox(width:15,),
              
                                  Row(
                                    children: [
                                      Icon(size: 24, Icons.money,color: Theme.of(context).primaryColor,),
                                      Text('${danceClass.price}', style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                        
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(),
                      SizedBox(height: 5,),
        
                     
                      SizedBox(height: 20,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Details", style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 5,),

                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                            ),
                            title: Text("PayMaya"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dance Description",style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 5,),

                           Text("Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",style: Theme.of(context).textTheme.bodyMedium,),
                        ],
                      )

                  ],
                ),
              ),
        
        
            ],
          ),
      ),
    );
  }
}