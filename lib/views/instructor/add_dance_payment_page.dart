import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/models/payment.dart';
import 'package:i_dance/views/instructor/review_created_dance_class.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/my_appbar.dart';

class AddPaymentPage extends StatelessWidget {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  String date,danceName,time,price,maxStudents,location;
  AddPaymentPage({super.key, required this.date,required this.danceName, required this.time, required this.price,required this.maxStudents,required this.location });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text('Add Payment Details',style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 5,),
              const Text('Please provide your payment details',textAlign: TextAlign.center,),
              const SizedBox(height: 30,),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                  trailing: Radio(value: "", groupValue: "", onChanged: (val){}),
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
                  if(Get.find<AuthController>().currentInstructor.value != null){

                    LiveDanceClassModel danceClass = LiveDanceClassModel(
                      -1,
                      danceClassId: -1,
                      danceName: danceName,
                      danceSong: "",
                      danceDifficulty: "",
                      price: int.parse(price),
                      description: "",
                      date: date,
                      location: location,
                      studentLimit: int.parse(maxStudents),
                      instructor: Get.find<AuthController>().currentInstructor.value!,
                      payment: Payment(-1,modeOfPayment: "paypal",
                      accountName: fullNameController.text,
                      accountNumber: referenceNumberController.text)
                    );
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