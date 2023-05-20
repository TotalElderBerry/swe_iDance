import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/sources/firebasestorage/firebase_storage.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../controllers/image/imagecontroller.dart';
import '../../models/live_dance_class.dart';

class ReviewDanceClassPage extends StatefulWidget {
  final LiveDanceClassModel danceClass;

  ReviewDanceClassPage({required this.danceClass});

  @override
  _ReviewDanceClassPageState createState() => _ReviewDanceClassPageState();
}

class _ReviewDanceClassPageState extends State<ReviewDanceClassPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(Get.find<ImagePickerController>().imgPathDanceClass.value),
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.danceClass.danceName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                _buildDifficultyTag(widget.danceClass.danceDifficulty),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                const SizedBox(width: 5),
                Text(
                  widget.danceClass.location,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                const SizedBox(width: 5),
                Text(
                  widget.danceClass.date,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(width: 15),
                Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                const SizedBox(width: 5),
                Text(
                  "12:00 PM",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(width: 15),
                Icon(Icons.money, color: Theme.of(context).primaryColor),
                const SizedBox(width: 5),
                Text(
                  '${widget.danceClass.price}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Details",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                  ),
                  title: Text("PayMaya"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        "Account Name: ${widget.danceClass.payment.accountName}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Account Number: ${widget.danceClass.payment.accountNumber}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dance Description",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.danceClass.description,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              try {
                Get.find<DanceClassController>().addLiveDanceClass(widget.danceClass);
                ImageCloudStorage.uploadDanceClassPicture(
                  widget.danceClass.instructor.instructorId,
                  widget.danceClass.danceClassId,
                  File(Get.find<ImagePickerController>().imgPathDanceClass.value),
                );
                Get.offAll(InstructorHome());
              } catch (e) {
                throw Exception(e);
              }
            },
            child: Text('Create Dance Class'),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyTag(String selectedDifficulty){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getDifficultyColor(selectedDifficulty),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        selectedDifficulty,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return Colors.green;
      case "Intermediate":
        return Colors.orange;
      case "Advanced":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
