import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/payment_details.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:i_dance/views/instructor/review_recorded_class.dart';

import '../../controllers/auth/auth_controller.dart';

class AddRecordedDancePage extends StatefulWidget {
  AddRecordedDancePage({Key? key}) : super(key: key);

  @override
  State<AddRecordedDancePage> createState() => _AddRecordedDancePageState();
}

class _AddRecordedDancePageState extends State<AddRecordedDancePage> {
 
  TextEditingController danceController = TextEditingController();
  TextEditingController songController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  String danceClassDescription = '';

  bool isEasy = true;

  bool isMedium = false;

  bool isHard = false;

  bool isPaymaya = true;
  bool isOnSite = false;

  String difficult = "Easy";

  int currentStep = 0;
  int? _value = 0;
  List<Step> steps = [];

  final List<String> difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];
  String selectedDifficulty = 'Beginner';


    @override
  void initState() {
    super.initState();
    
  }
  

  @override
  Widget build(BuildContext context) {
    steps = [
      Step(
        title: const Text('Basic Details'),
        content: Column(
              children: [
                
                const Text(
                  'This section contains general information of your recorded dance class',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                
                TextField(
                  textCapitalization: TextCapitalization.words,
                  controller: danceController,
                  decoration:
                      const InputDecoration(labelText: "Dance Class Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: songController,
                        decoration: const InputDecoration(
                          labelText: "Song",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.music_note),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: linkController,
                        decoration: const InputDecoration(
                          labelText: "Link",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.link),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
              controller: detailsController,
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
      appBar: AppBar(title: Text("Add Recorded Dance Class"),),
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
            if(Get.find<AuthController>().currentInstructor.value != null){

              RecordedDanceClassModel recordedDanceClass = RecordedDanceClassModel(-1, youtubeLink: linkController.text, danceClassId: -1, price: int.parse(priceController.text), danceName: danceController.text, danceSong: songController.text, danceDifficulty: difficult, description: detailsController.text, payment: PaymentDetails(-1,accountName: fullNameController.text, accountNumber: referenceNumberController.text, modeOfPayment: 'Paypal'), instructor: Get.find<AuthController>().currentInstructor.value!);
              Get.to(ReviewRecordedClass(recordedDanceClass: recordedDanceClass,));
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
}