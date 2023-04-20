import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/views/instructor/review_created_dance_class.dart';

import '../../widgets/my_appbar.dart';

class AddPaymentPage extends StatelessWidget {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  String date,danceName,time,price,maxStudents;
  AddPaymentPage({super.key, required this.date,required this.danceName, required this.time, required this.price,required this.maxStudents});

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
                  // LiveDanceClassModel danceClass = LiveDanceClassModel(
                  //   instructorId: "",
                  //   danceName: "",
                  //   danceSong: "",
                  //   danceDifficulty: "",
                  //   price: "",
                  //   description: "",
                  //   isAcceptingPayment: "",
                  // )
                  Get.to(ReviewDanceClassPage());
                },child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}