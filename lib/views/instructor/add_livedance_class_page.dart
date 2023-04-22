import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';
import 'package:latlong2/latlong.dart';

import '../../controllers/image/imagecontroller.dart';
import '../../widgets/map.dart';
import '../../widgets/my_appbar.dart';

//10.3156992 , 123.88543660000005

class AddLiveDanceClassPage extends StatelessWidget {
  TextEditingController dateController = TextEditingController();
  TextEditingController danceNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxStudentsController = TextEditingController();

  AddLiveDanceClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 32.0, left: 32, ),
          child: Column(
            children: [
               Text('Provide Basic Details',style: Theme.of(context).textTheme.headlineMedium),
               const SizedBox(height: 5,),
              const Text('This section contains general information of your dance class',textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
      
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: Colors.grey[100],
                  child: 
                  Obx((){
                    if(Get.find<ImagePickerController>().imgPathDanceClass.value == ''){
                      return SizedBox(
                          child: IconButton(
                          onPressed: (){
                            Get.find<ImagePickerController>().pickImageForClass();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.camera_alt)),
                          width: (MediaQuery.of(context).size.width),
                          height: 150,
                        );
                    }else{
                      return GestureDetector(
                        onTap: () => Get.find<ImagePickerController>().pickImageForClass(),
                        onLongPress: () => Get.find<ImagePickerController>().imgPathDanceClass.value = '',
                        child: SizedBox(
                            child: Image.file(File(Get.find<ImagePickerController>().imgPathDanceClass.value),fit: BoxFit.cover,),
                            width: (MediaQuery.of(context).size.width),
                            height: 150,
                          ),
                      );
                    }
                  }
                )
                  
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Dance Class Name"
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date",
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000), // Refer step 1
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );

                                if(picked != null){
                                  dateController.text = picked.toString().split(" ")[0];
                                }
                              },
                              icon: Icon(Icons.calendar_month),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter date";
                            }
                            return null;
                          },
                          
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: "Time",
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                print(picked!.format(context));
                                if(picked != null){
                                  timeController.text = picked.format(context).toString();
                                }
                              },
                              icon: Icon(Icons.access_time),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your time";
                            }
                            return null;
                          },
                          
                        ),
                      ),
                ],
              ),
              Expanded(
                        child: TextFormField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: "Location",
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                showDialog(context: context, builder: (BuildContext context){
                                  return Dialog(
                                      child: Container(
                                        constraints: BoxConstraints(maxHeight: 350),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              TextField(),
                                              const SizedBox(height: 10,),
                                              Expanded(
                                                child: MapWidget()
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                });
                              },
                              icon: Icon(Icons.location_city),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your time";
                            }
                            return null;
                          },
                          
                        ),
                      ),
              const SizedBox(height: 10,),
               Row(
                children: [
                  Expanded(
                        child: TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            border: OutlineInputBorder(),
                            isDense: true,
                            icon:  Icon(Icons.money),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: maxStudentsController,
                          decoration: InputDecoration(
                            labelText: "Max Students",
                            border: OutlineInputBorder(),
                            isDense: true,
                            icon: Icon(Icons.people_alt),
                            
                          ),
                        ),
                      ),
                ],
              ),
              const Spacer(),
              Container(
                width: (MediaQuery.of(context).size.width),
                child: ElevatedButton(onPressed: (){
                  Get.to(AddPaymentPage(date: dateController.text, danceName: danceNameController.text, time: timeController.text,price: priceController.text,maxStudents: maxStudentsController.text,));
                },child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}