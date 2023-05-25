import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/models/payment_details.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:i_dance/views/instructor/review_created_dance_class.dart';
import 'package:i_dance/views/instructor/review_recorded_class.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/my_appbar.dart';

class AddRecordedPaymentPage extends StatelessWidget {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  RecordedDanceClassModel recordedDanceClassModel;
  AddRecordedPaymentPage({super.key, required this.recordedDanceClassModel });

  bool isPaymaya = true;
  bool isOnSite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: (){
            if(Get.find<AuthController>().currentInstructor.value != null){
                    recordedDanceClassModel.payment.accountName = fullNameController.text;
                    recordedDanceClassModel.payment.accountNumber = referenceNumberController.text;
                    recordedDanceClassModel.payment.modeOfPayment = "Paypal";
                    print(recordedDanceClassModel.toJson().toString());
                   Get.to(ReviewRecordedClass(recordedDanceClass: recordedDanceClassModel,));
                  // Get.to(ReviewDanceClassPage(danceClass: danceClass));
            }
          },
          child: const Center(
            child: Text('Next'),
          ),
        ),
      ),
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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                  trailing:
                      Radio(value: "", groupValue: "", onChanged: (val) {}),
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
            ],
          ),
        ),
      ),
    );
  }
}
