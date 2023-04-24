import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/review_recorded_class.dart';

import '../../widgets/my_appbar.dart';

class AddPaymentPage extends StatelessWidget {
  TextEditingController dateController = TextEditingController();
  AddPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
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
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Reference Number"),
              ),
              const Spacer(),
              Container(
                width: (MediaQuery.of(context).size.width),
                child: ElevatedButton(
                    onPressed: () => Get.to(const ReviewRecordedClass()),
                    child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
