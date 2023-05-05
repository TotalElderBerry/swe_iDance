import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/generateRefNumber.dart';
import '../student/pay_page.dart';
import 'package:http/http.dart' as http;


class ReviewRecordedClass extends StatelessWidget {
  RecordedDanceClassModel recordedDanceClass;
  ReviewRecordedClass({super.key, required this.recordedDanceClass});

  @override
  Widget build(BuildContext context) {
    String link = recordedDance.last['link'];
    RegExp regExp = RegExp(r"(?<=v=)[\w-]+");
    RegExpMatch? match = regExp.firstMatch(link);
    String? id = match?.group(0);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  "totalAmount": {"value": recordedDanceClass.price, "currency": 'PHP'},
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
              final redirectLink = Uri.parse(res['redirectUrl']);
              // Get.find<StudentController>().bookDanceClass(liveClass.danceClassId,refNumber, liveClass.price);
              Get.to(PaymentPage(url: res['redirectUrl'],));
              // print("hello");
              // print(liveClass.liveClassId);
            }

          },
          child: const Center(
            child: Text('Create Dance'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  'https://i.ytimg.com/vi/$id/maxresdefault.jpg',
                  fit: BoxFit.fill,
                ),
                Text(
                  recordedDance.last['classname'],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.music_note,
                          color: Colors.purple,
                        ),
                        Text(recordedDance.last['song']),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          color: Colors.purple,
                        ),
                        Text(recordedDance.last['difficulty']),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.money,
                          color: Colors.purple,
                        ),
                        Text(recordedDance.last['price']),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.link,
                          color: Colors.purple,
                        ),
                        TextButton(
                          onPressed: () => launchUrl(
                            Uri.parse('https://' + recordedDance.last['link']),
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(recordedDance.last['link']),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                ),
                const ListTile(
                  leading: Text('Full Name'),
                  title: Text('Juan Dela Cruz'),
                ),
                const ListTile(
                  leading: Text('Reference Number'),
                  title: Text('ASDJKJ29UASKDJ'),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Dance Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(recordedDance.last['details']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
