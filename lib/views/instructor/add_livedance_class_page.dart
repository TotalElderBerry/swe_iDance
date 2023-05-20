import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/views/instructor/review_created_dance_class.dart';

import '../../controllers/image/imagecontroller.dart';
import '../../models/live_dance_class.dart';
import '../../models/payment_details.dart';
import '../../widgets/map.dart';
import '../../widgets/my_appbar.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class AddLiveDanceClassPage extends StatefulWidget {
  AddLiveDanceClassPage({Key? key}) : super(key: key);

  @override
  State<AddLiveDanceClassPage> createState() => _AddLiveDanceClassPageState();
}

class _AddLiveDanceClassPageState extends State<AddLiveDanceClassPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng showLocation = LatLng(10.3156992, 123.88543660000005);
  String location = "Search Location";
  CameraPosition? cameraPosition;
  TextEditingController dateController = TextEditingController();
  TextEditingController danceNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController maxStudentsController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  TextEditingController danceClassDescriptionController = TextEditingController();
  String danceClassDescription = '';

  int currentStep = 0;
  int? _value = 0;
  List<Step> steps = [];

  final List<String> difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];
  String selectedDifficulty = 'Beginner';

  @override
  void initState() {
    super.initState();
    markers.add(
      Marker(
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: InfoWindow(
          title: 'My Custom Title',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    
  }

  @override
  Widget build(BuildContext context) {
    steps = [
      Step(
        title: const Text('Basic Details'),
        content: Column(
          children: [
            const Text(
              'This section contains general information of your dance class',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[100],
                child: Obx(
                  () {
                    if (Get.find<ImagePickerController>().imgPathDanceClass.value == '') {
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
                  },
                ),
              ),
            ),
            TextFormField(
              controller: danceNameController,
              decoration: const InputDecoration(
                labelText: 'Dance Class Name',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                          );

                          if (picked != null) {
                            dateController.text = picked.toString().split(' ')[0];
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter date';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (picked != null) {
                            timeController.text = picked.format(context).toString();
                          }
                        },
                        icon: const Icon(Icons.access_time),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your time';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          // Dialog code here
                        },
                        icon: const Icon(Icons.location_city),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: const Icon(Icons.money),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Difficulty Level'),
        content: Column(
          children: [
            const Text(
              'Please select the difficulty level of your dance class',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              // children: difficultyLevels.map((level) {
              //   print(level);
              //   return ChoiceChip(
              //     label: Text(level),
              //     selected: selectedDifficulty == level,
              //     onSelected: (selected) {
              //       setState(() {
              //       print(level);
              //         if (selected) {
              //           selectedDifficulty = level;
              //         }
              //       });
              //     },
              //   );
              // }).toList(),
              children: List<Widget>.generate(
                  3,
                  (int index) {
                    return ChoiceChip(
                      label: Text(difficultyLevels[index]),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;
                        });
                      },
                    );
                  },
                ).toList(),
            ),
          ],
        ),
        isActive: true,
      ),

      Step(
        title: const Text('Additional Detail'),
        content: Column(
          children: [
            const Text(
              'Please provide a description of your dance class',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: danceClassDescriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                  danceClassDescription = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the dance class description';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: true,
      ),

      Step(
        title: const Text('Add Payment'),
        content: Column(
          children: [
            const Text(
                'Please provide your payment details',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                  trailing:
                      Radio(value: "", groupValue: "", onChanged: (val) {}),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              )
              ,
              const SizedBox(height: 10,),
              TextField(
                controller: referenceNumberController,
                decoration: InputDecoration(
                  labelText: "Reference Number",
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              )
              ,
          ],
        ),
        isActive: true
      ),

      Step(
        title: const Text('Review and Submit'),
        content: Column(
          children: [
            const Text(
              'Please review your dance class details and submit',
              textAlign: TextAlign.center,
            ),
            // Display the selected options and other details for review
          ],
        ),
        isActive: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Add Live Dance Class"),),
      body: Stepper(
        currentStep: currentStep,
        steps: steps,
        onStepContinue: () {
          if (currentStep < steps.length - 1) {
            setState(() {
              currentStep += 1;
            });
          } else {
            // Perform the submission logic here
            print(Get.find<AuthController>().currentInstructor.value);
                if(Get.find<AuthController>().currentInstructor.value != null){

                  LiveDanceClassModel danceClass = LiveDanceClassModel(
                    -1,
                    danceClassId: -1,
                    danceName: danceNameController.text,
                    danceSong: "",
                    danceDifficulty: difficultyLevels[_value!],
                    price: int.parse(priceController.text),
                    description: danceClassDescriptionController.text,
                    date: dateController.text,
                    location: locationController.text,
                    studentLimit: 100,
                    instructor: Get.find<AuthController>().currentInstructor.value!,
                    payment: PaymentDetails(-1,modeOfPayment: "paypal",
                    accountName: fullNameController.text,
                    accountNumber: referenceNumberController.text)
                  );
                  print(danceClass);
                Get.to(ReviewDanceClassPage(danceClass: danceClass));
            }
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep -= 1;
            });
          }
        },
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    showLocation = position.target;
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: InfoWindow(
          title: 'My Custom Title',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void _onCameraIdle() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      showLocation.latitude,
      showLocation.longitude,
    );
    if (placemarks.isNotEmpty) {
      setState(() {
        location = placemarks[0].name.toString();
        locationController.text = location;
      });
    }
  }
}
