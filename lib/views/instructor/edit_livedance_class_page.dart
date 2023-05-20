import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/image/imagecontroller.dart';
import '../../widgets/my_appbar.dart';
import 'add_dance_payment_page.dart';


class EditLiveDancePage extends StatefulWidget {
  const EditLiveDancePage({Key? key}) : super(key: key);

  @override
  State<EditLiveDancePage> createState() => _EditLiveDancePageState();
}

class _EditLiveDancePageState extends State<EditLiveDancePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  bool isEasy = true;

  bool isMedium = false;

  bool isHard = false;


  @override
  void initState() {
    dateController.text = DateTime.now().toString().split(" ")[0];
    timeController.text = DateTime.now().toString().split(" ")[1].split(".")[0];
    priceController.text = "50";
    maxController.text = "10";
    super.initState();
  }
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
            'Are you sure you want to update',
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context,isStudent: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 140,
            child: Column(
              children: [
                Text('Update Live Dance Class',style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 10,),

                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                      color: Colors.grey[100],
                      child:
                      Obx((){
                        if(Get.find<ImagePickerController>().imgPath.value == ''){
                          return SizedBox(
                            child: IconButton(
                                onPressed: (){
                                  Get.find<ImagePickerController>().pickImage();
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: const Icon(Icons.camera_alt)),
                            width: (MediaQuery.of(context).size.width),
                            height: 150,
                          );
                        }else{
                          return GestureDetector(
                            onTap: () => Get.find<ImagePickerController>().pickImage(),
                            onLongPress: () => Get.find<ImagePickerController>().imgPath.value = '',
                            child: SizedBox(
                              child: Image.file(File(Get.find<ImagePickerController>().imgPath.value),fit: BoxFit.cover,),
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
                            border: const OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000), // Refer step 1
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );
                              },
                              icon: const Icon(Icons.calendar_month),
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
                            border: const OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                              },
                              icon: const Icon(Icons.access_time),
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
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon:  Icon(Icons.money),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: maxController,
                        decoration: const InputDecoration(
                          labelText: "Max Students",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.people_alt),

                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Difficulty',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isEasy = true;
                            isMedium = false;
                            isHard = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color:
                            isEasy == true ? Colors.purple : Colors.white,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: Center(
                              child: Text(
                                'Easy',
                                style: TextStyle(
                                    color: isEasy == true
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
                            isMedium = true;
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
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color:
                            isHard == true ? Colors.purple : Colors.white,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: Center(
                              child: Text(
                                'Hard',
                                style: TextStyle(
                                    color: isHard == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        maxLines: null,
                        controller: detailsController,
                        decoration: const InputDecoration(
                          labelText: "Details",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.info),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  child: ElevatedButton(onPressed: (){
                    _showDialog(context);
                    Get.to(EditLiveDancePage());
                  },child: const Text("Update")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

