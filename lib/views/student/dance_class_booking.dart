import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/views/student/pay_page.dart';

import '../../controllers/notification/notifcontroller.dart';
import '../../models/live_dance_class.dart';
import '../../utils/generateRefNumber.dart';

class JoinDanceClassPage extends StatefulWidget {
  JoinDanceClassPage({required this.liveClass, Key? key}) : super(key: key);
  LiveDanceClassModel liveClass;

  @override
  State<JoinDanceClassPage> createState() => _JoinDanceClassPageState();
}

class _JoinDanceClassPageState extends State<JoinDanceClassPage> {

  bool isPaymaya = true;
  bool isOnSite = false;
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
                    "totalAmount": {"value": widget.liveClass.price, "currency": 'PHP'},
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
              // await Get.find<StudentController>().bookDanceClass(liveClass.danceClassId,refNumber, liveClass.price);
              Get.find<StudentController>().socketBookDanceClass(widget.liveClass);
              Get.find<NotificationController>().listenNotifications();

              // Get.to(PaymentPage(url: res['redirectUrl'],));
              // print("hello");
              // print(liveClass.liveClassId);
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
            Divider(),

            Visibility(
              visible: isPaymaya,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Name"),
                        trailing: Text(widget.liveClass.payment.accountName),
                      ),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                      ),
                      ListTile(
                        title: Text("Reference Number"),
                        trailing: Text(widget.liveClass.payment.accountNumber),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

