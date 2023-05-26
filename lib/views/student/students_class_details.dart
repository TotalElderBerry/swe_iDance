import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/models/attendance_model.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:quickalert/quickalert.dart';

class StudentDanceClassDetails extends StatefulWidget {
  LiveDanceClassModel liveDance;
  bool isPending, isCancelled;
  StudentDanceClassDetails(
      {super.key,
      required this.isPending,
      required this.liveDance,
      required this.isCancelled});

  @override
  State<StudentDanceClassDetails> createState() =>
      _StudentDanceClassDetailsState();
}

class _StudentDanceClassDetailsState extends State<StudentDanceClassDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: Obx(() {
            return (widget.isPending == false &&
                    Get.find<StudentController>().isDone.value == false)
                ? ElevatedButton(
                    onPressed: () async {
                      String COLOR_CODE = '#ffffff';
                      String CANCEL_BUTTON_TEXT = 'CANCEL';
                      bool isShowFlashIcon = true;
                      ScanMode scanMode = ScanMode.QR;
                      String qr = await FlutterBarcodeScanner.scanBarcode(
                        COLOR_CODE,
                        CANCEL_BUTTON_TEXT,
                        isShowFlashIcon,
                        scanMode,
                      );
                      print(qr);

                      await Get.find<StudentController>()
                          .attendDanceClass(
                              Get.find<AuthController>()
                                  .currentUser
                                  .value!
                                  .studentId,
                              int.parse(qr))
                          .then((res) => {
                                // print(res);
                                if (res == true)
                                  {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Attended Successfully!',
                                    )
                                  }
                                else
                                  {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: 'Attendance Failed',
                                    )
                                  }
                              });
                      // ignore: use_build_context_synchronously
                    },
                    child: const Center(
                      child: Text('Attendance'),
                    ),
                  )
                : (Get.find<StudentController>().isDone == true)
                    ? ElevatedButton(
                        onPressed: () {
                          int rate = 5;
                          QuickAlert.show(
                            title:
                                "Rate Teacher ${widget.liveDance.instructor.firstName}",
                            text: "Please rate your instructor below",
                            type: QuickAlertType.confirm,
                            widget: RatingBar.builder(
                                itemSize: 40.0,
                                initialRating: 5.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (a) => {rate = a.toInt()}),
                            onConfirmBtnTap: () async {
                              print(rate);
                              await Get.find<StudentController>()
                                  .giveRatingToInstructor(
                                      widget.liveDance.instructor.instructorId,
                                      rate);
                              Navigator.pop(context);
                            },
                            context: context,
                          );
                        },
                        child: const Center(
                          child: Text('Rate Instructor'),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: (widget.isCancelled)
                            ? null
                            : () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text("Cancel Dance Class Booking?"),
                                        content: Text(
                                            "Do you wish to cancel ${widget.liveDance.danceName}?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await Get.find<
                                                        StudentController>()
                                                    .cancelDanceClass(widget
                                                        .liveDance
                                                        .danceClassId);
                                                Get.find<StudentController>()
                                                    .requestCancelBooking(
                                                        widget.liveDance);
                                                setState(() {
                                                  widget.isCancelled = true;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No")),
                                        ],
                                      );
                                    });
                              },
                        child: const Center(
                          child: Text('Cancel'),
                        ),
                      );
          })),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: (widget.liveDance.img == "")
                    ? const SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey)),
                      )
                    : Image.network(
                        widget.liveDance.img!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
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
                          widget.liveDance.danceName,
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
                          widget.liveDance.location,
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
                                  widget.liveDance.date,
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
                                  "${widget.liveDance.price} Pesos",
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
                              widget.liveDance.instructor.profilePicture!),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.liveDance.instructor.firstName} ${widget.liveDance.instructor.lastName}",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.liveDance.description,
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
