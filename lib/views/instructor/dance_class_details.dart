import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/attendance.dart';
import 'package:i_dance/views/instructor/student_list.dart';

import '../../models/live_dance_class.dart';
import 'edit_livedance_class_page.dart';

class DanceClassDetails extends StatelessWidget {
  final LiveDanceClassModel liveDance;

  DanceClassDetails({Key? key, required this.liveDance}) : super(key: key);

  Widget _buildDifficultyTag(String difficulty) {
    Color tagColor;
    String tagText;
    IconData tagIcon;

    switch (difficulty) {
      case "Easy":
      case "Beginner":
        tagColor = Colors.green;
        tagText = "Beginner";
        tagIcon = Icons.accessible;
        break;
      case "Intermediate":
      case "Medium":
        tagColor = Colors.orange;
        tagText = "Intermediate";
        tagIcon = Icons.timeline;
        break;
      case "Advanced":
      case "Hard":
        tagColor = Colors.red;
        tagText = "Advanced";
        tagIcon = Icons.whatshot;
        break;
      default:
        tagColor = Colors.grey;
        tagText = "N/A";
        tagIcon = Icons.help;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            tagIcon,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            tagText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dance Class Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Add your edit dance class logic here
              Get.to(EditLiveDancePage(liveDance: liveDance,));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: liveDance.img!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(liveDance.img!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: liveDance.img!.isNotEmpty ? null : Colors.grey,
                ),
                child: liveDance.img!.isEmpty
                    ? Center(
                        child: Text(
                          'No Image Uploaded',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    : null,
              ),
              SizedBox(height: 16),
              Text(
                liveDance.danceName,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        liveDance.date,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        '\$${liveDance.price}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        liveDance.location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Get.to(StudentListScreen(initIndex: 0, liveDance: liveDance)),
                    icon: Icon(Icons.pending_actions, color: Colors.white),
                    label: Text('Pending'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Get.to(StudentListScreen(initIndex: 1, liveDance: liveDance)),
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text('Approved'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              Text(
                liveDance.description,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AttendanceScreen(liveDance: liveDance)),
        child: Icon(Icons.assignment),
      ),
    );
  }
}
