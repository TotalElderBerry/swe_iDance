import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/attendance.dart';
import 'package:i_dance/views/instructor/student_list.dart';

import '../../models/live_dance_class.dart';

class DanceClassDetails extends StatelessWidget {
  LiveDanceClassModel liveDance;
  DanceClassDetails({super.key, required this.liveDance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () => Get.to(AttendanceScreen()),
          child: const Center(
            child: Text('Attendance'),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                    fit: BoxFit.contain,
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.music_note,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Cupid',
                          style: TextStyle(color: Colors.white, fontSize: 11),
      
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        label: Text(
                          'March 12, 2023',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        label: Text(
                          '12:00 PM',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        label: Text(
                          'UC Main Campus',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Chip(
                        avatar: const Icon(
                          size: 18,
                          Icons.money,
                          color: Colors.white,
                        ),
                        label: Text(
                          '400 Pesos',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.pending_outlined),
                            iconSize: 30,
                            onPressed: () => Get.to(StudentListScreen(
                              initIndex: 0,
                              liveDance: liveDance,
                            )),
                          ),
                          Text("Pending"),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.approval),
                            iconSize: 30,
                            onPressed: () => Get.to(StudentListScreen(
                              initIndex: 1,
                              liveDance: liveDance,
                            )),
                          ),
                          Text("Approved"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Description:",
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
            ],
          ),
        ),
      ),
    );
  }
}
