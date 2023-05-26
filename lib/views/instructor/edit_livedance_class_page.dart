import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../controllers/image/imagecontroller.dart';
import '../../models/live_dance_class.dart';
import '../../widgets/my_appbar.dart';
import 'add_dance_payment_page.dart';
import 'instructor_home.dart';

class EditLiveDancePage extends StatefulWidget {

  LiveDanceClassModel liveDance;
  EditLiveDancePage({Key? key, required this.liveDance}) : super(key: key);

  @override
  State<EditLiveDancePage> createState() => _EditLiveDancePageState();
}

class _EditLiveDancePageState extends State<EditLiveDancePage> {
  TextEditingController danceNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String difficulty = " ";
  bool isEasy = true;
  bool isMedium = false;
  bool isHard = false;

  @override
  void initState() {
    danceNameController.text = widget.liveDance.danceName;
    dateController.text = DateTime.now().toString().split(" ")[0];
    timeController.text = DateTime.now().toString().split(" ")[1].split(".")[0];
    priceController.text = widget.liveDance.price.toString();
    detailsController.text = widget.liveDance.description;
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
                Get.find<DanceClassController>().updateLiveDanceClass(widget.liveDance);
                Get.offAll(InstructorHome());
                // Navigator.of(context).pop();
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text(
              'Update Live Dance Class',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        color: Colors.grey[100],
                        child: Obx(() {
                         if (Get.find<ImagePickerController>().imgPathDanceClass.value == '') {
                          if(widget.liveDance.img!.isEmpty){
                            return SizedBox(
                              child: IconButton(
                                onPressed: () {
                                  Get.find<ImagePickerController>().pickImageForClass();
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: const Icon(Icons.camera_alt),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                            );
                          }
                          return GestureDetector( 
                            onTap: () => Get.find<ImagePickerController>().pickImageForClass(),
                        onLongPress: () => Get.find<ImagePickerController>().imgPathDanceClass.value = '',
                            child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                      image: NetworkImage(widget.liveDance.img!),
                                      fit: BoxFit.cover,
                                    )
                            
                                                  )
                            ),
                          );
                    } else {
                      return GestureDetector(
                        onTap: () => Get.find<ImagePickerController>().pickImageForClass(),
                        onLongPress: () => Get.find<ImagePickerController>().imgPathDanceClass.value = '',
                        child: SizedBox(
                          child: Image.file(
                            File(Get.find<ImagePickerController>().imgPathDanceClass.value),
                            fit: BoxFit.cover,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                        ),
                      );
                    }
                      }),

                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                       validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter dance class name";
                      }
                      return null;
                    },
                      decoration: InputDecoration(
                        labelText: "Dance Class Name",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
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
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter date";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
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
                              ),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter price";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                            controller: priceController,
                            decoration: const InputDecoration(
                              labelText: "Price",
                              border: OutlineInputBorder(),
                              isDense: true,
                              suffixIcon: Icon(Icons.money),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Difficulty',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
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
                                color: isEasy == true ? Colors.purple : Colors.white,
                                border: Border.all(
                                  color: Colors.purple,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Easy',
                                  style: TextStyle(
                                    color: isEasy == true ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                                color: isMedium == true ? Colors.purple : Colors.white,
                                border: Border.all(
                                  color: Colors.purple,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Medium',
                                  style: TextStyle(
                                    color: isMedium == true ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                                color: isHard == true ? Colors.purple : Colors.white,
                                border: Border.all(
                                  color: Colors.purple,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Hard',
                                  style: TextStyle(
                                    color: isHard == true ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter dance class details";
                            }
                            return null;
                          },
                      controller: detailsController,
                      decoration: const InputDecoration(
                        labelText: "Dance Class Details",
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _showDialog(context),
              child: const Text('Update'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 244, 209, 235),
                  ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
