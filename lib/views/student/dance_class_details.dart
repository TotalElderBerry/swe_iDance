import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/attendance_model.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';
import 'package:quickalert/quickalert.dart';

class DanceClassDetails extends StatelessWidget {
  DanceClassDetails({super.key, required this.fromPage});

  String fromPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: fromPage == "CardUpcoming"
            ? ElevatedButton(
                onPressed: () async {
                  String COLOR_CODE = '#ffffff';
                  String CANCEL_BUTTON_TEXT = 'CANCEL';
                  bool isShowFlashIcon = true;
                  ScanMode scanMode = ScanMode.DEFAULT;
                  String qr = await FlutterBarcodeScanner.scanBarcode(
                    COLOR_CODE,
                    CANCEL_BUTTON_TEXT,
                    isShowFlashIcon,
                    scanMode,
                  );
                  attended.add(
                    {
                      "Name": "Jose Cruz",
                      "Date": "2023-04-21 - 05:57",
                    },
                  );
                  // ignore: use_build_context_synchronously
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Qr Scanned Successfully!',
                  );
                },
                child: const Center(
                  child: Text('Attendance'),
                ),
              )
            : fromPage == "CardPending"
                ? ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                      child: Text('Cancel'),
                    ),
                  )
                : fromPage == "StudentHomeLive"
                    ? ElevatedButton(
                        onPressed: () => Get.to(AddPaymentPage()),
                        child: const Center(
                          child: Text('Book Dance Class'),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () => Get.to(AddPaymentPage()),
                        child: const Center(
                          child: Text('Buy Dance Class'),
                        ),
                      ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                  fit: BoxFit.contain,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Run - BTS",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          size: 24,
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          " UC Main Campus",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  size: 24,
                                  Icons.calendar_month,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "March 12,2023",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  size: 24,
                                  Icons.access_time,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "12:00 PM",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  size: 24,
                                  Icons.money,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "400 Pesos",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Roger Intong",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
