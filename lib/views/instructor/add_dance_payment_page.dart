import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/models/payment_details.dart';
import 'package:i_dance/views/instructor/review_created_dance_class.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/my_appbar.dart';

class AddPaymentPage extends StatefulWidget {
  AddPaymentPage({super.key, required this.date,required this.danceName, required this.time, required this.price,required this.maxStudents,required this.location });
  final date;
  final danceName;
  final time;
  final price;
  final maxStudents;
  final location;

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();

  bool isPaymaya = true;
  bool isOnSite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text('Add Payment Details',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: 5,
              ),
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
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: const Text("PayMaya"),
                  trailing: Radio(
                    value: true,
                    groupValue: isPaymaya,
                    onChanged: (bool? value) {
                      print(value);
                      if (value != null) {
                        setState(() {
                          isPaymaya = value;
                        });
                        print(isPaymaya);
                      }
                    },
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.business_outlined,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Pay On Site"),
                  trailing:
                  Radio(
                    value: true,
                    groupValue: !isPaymaya,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isPaymaya = !value;
                        });
                      }
                    },
                  ),

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isPaymaya,
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
              ),
              Visibility(
                visible: isPaymaya,
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your card number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Reference Number"),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                    labelText: "Full Name"
                ),
              ),
              TextField(
                controller: referenceNumberController,
                decoration: InputDecoration(
                    labelText: "Reference Number"
                ),
              ),
              const Spacer(),
              Container(
                width: (MediaQuery.of(context).size.width),
                child: ElevatedButton(onPressed: (){
                  print(Get.find<AuthController>().currentInstructor.value);
                  if(Get.find<AuthController>().currentInstructor.value != null){

                    LiveDanceClassModel danceClass = LiveDanceClassModel(
                        -1,
                        danceClassId: -1,
                        danceName: widget.danceName,
                        danceSong: "",
                        danceDifficulty: "",
                        price: int.parse(widget.price),
                        description: "",
                        date: widget.date,
                        location: widget.location,
                        studentLimit: int.parse(widget.maxStudents),
                        instructor: Get.find<AuthController>().currentInstructor.value!,
                        payment: PaymentDetails(-1,modeOfPayment: "paypal",
                            accountName: fullNameController.text,
                            accountNumber: referenceNumberController.text)
                    );
                    print(danceClass);
                    Get.to(ReviewDanceClassPage(danceClass: danceClass));
                  }
                },child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}