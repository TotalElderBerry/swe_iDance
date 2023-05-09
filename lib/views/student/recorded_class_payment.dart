import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:i_dance/views/student/pay_page.dart';

import '../../models/live_dance_class.dart';
import '../../utils/generateRefNumber.dart';
class RecordedClassPaymentPage extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClassModel;
  
  RecordedClassPaymentPage({super.key, required this.recordedDanceClassModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () async {
            
            String refNumber = generateReferenceNumber(7);
            refNumber += "-";
            refNumber += generateReferenceNumber(4);
            refNumber += "-";
            refNumber += generateReferenceNumber(4);
            refNumber += "-";
            refNumber += generateReferenceNumber(4);
            refNumber += "-";
            refNumber += generateReferenceNumber(7);
            final response = await http.post(Uri.parse('https://pg-sandbox.paymaya.com/checkout/v1/checkouts'),
              body: jsonEncode(
                <String,dynamic> {
                  "totalAmount": {"value": recordedDanceClassModel.price, "currency": 'PHP'},
                  "requestReferenceNumber": refNumber,
                  "redirectUrl": {
                    "success": 'https://www.merchantsite.com/success?id=5fc10b93-bdbd-4f31-b31d-4575a3785009',
                    "failure": 'https://www.mechantsite.com/failure?id=5fc10b93-bdbd-4f31-b31d-4575a3785009',
                    "cancel": 'https://www.merchantsite.com/cancel?id=5fc10b93-bdbd-4f31-b31d-4575a3785009'
                  }
                }
              ),
              headers: {
                'content-type': 'application/json',
                "authorization": 'Basic cGstWjBPU3pMdkljT0kyVUl2RGhkVEdWVmZSU1NlaUdTdG5jZXF3VUU3bjBBaDo='
              },
            );

            if(response.statusCode == 200){
              final res = jsonDecode(response.body);
              await Get.find<StudentController>().bookDanceClass(recordedDanceClassModel.danceClassId,refNumber, recordedDanceClassModel.price);
              Get.to(PaymentPage(url: res['redirectUrl'],));
              // print("hello");
              // print(recordedDanceClassModel.recordedDanceClassModelId);
            }

          },
          child: const Center(
            child: Text('Pay'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text("Payment Details", style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: 10,),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
              ),
              title: Text("PayMaya"),
              trailing: Radio(value: "", groupValue: "", onChanged: (val){}),
            ),
            Divider(),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Name"),
                      trailing: Text(recordedDanceClassModel.payment.accountName),
                    ),
                    Divider(
                      indent: 5,
                      endIndent: 5,
                    ),
                    ListTile(
                      title: Text("Reference Number"),
                      trailing: Text(recordedDanceClassModel.payment.accountNumber),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}