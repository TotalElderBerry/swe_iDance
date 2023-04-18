import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:i_dance/views/student/pay_page.dart';

class JoinDanceClassPage extends StatelessWidget {
  const JoinDanceClassPage({super.key});

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
            
            final response = await http.post(Uri.parse('https://pg-sandbox.paymaya.com/checkout/v1/checkouts'),
              body: jsonEncode(
                <String,dynamic> {
                  "totalAmount": {"value": "100", "currency": 'PHP'},
                  "requestReferenceNumber": '5fc10b93-bdbd-4f31-b31d-4575a3785009'
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
              print(res['redirectUrl']);
              Get.to(PaymentPage(url: res['redirectUrl'],));
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
            Divider()
          ],
        ),
      ),
    );
  }
}