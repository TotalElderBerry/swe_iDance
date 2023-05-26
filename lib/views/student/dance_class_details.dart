import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/views/student/dance_class_booking.dart';

import '../../models/live_dance_class.dart';
import '../instructor/add_dance_payment_page.dart';
import 'instructor_details_page.dart';

import '../../utils/getDaysBetween.dart';

class DanceClassDetails extends StatefulWidget {
  final LiveDanceClassModel liveClass;

  DanceClassDetails({Key? key, required this.liveClass}) : super(key: key);

  @override
  State<DanceClassDetails> createState() => _DanceClassDetailsState();
}

class _DanceClassDetailsState extends State<DanceClassDetails> {
  @override
  Widget build(BuildContext context) {
    print("live class id ${widget.liveClass.liveClassId} and dance class id ${widget.liveClass.danceClassId}");

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (getDaysBetweenFromToday(widget.liveClass.date) > 0)
          ? Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(JoinDanceClassPage(liveClass: widget.liveClass));
                },
                style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>( Color.fromARGB(255, 244, 209, 235),),
        ),
                child: Center(
                child: Text(
                  'Book this Class',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
              ),
            )
          : Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: null,
            ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: (widget.liveClass.img == "")
                    ? const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: DecoratedBox(decoration: const BoxDecoration(color: Colors.grey)),
                      )
                    : Image.network(
                        widget.liveClass.img!,
                        fit: BoxFit.fill,
                        height: 200,
                        width: double.infinity,
                      ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.liveClass.danceName, style: Theme.of(context).textTheme.headlineLarge),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              if (widget.liveClass.isLiked == 0) {
                                widget.liveClass.isLiked = 1;
                                Get.find<StudentController>().likedClasses.add(widget.liveClass);
                              } else {
                                Get.find<StudentController>().likedClasses.remove(widget.liveClass);
                                widget.liveClass.isLiked = 0;
                              }
                            });

                            await Get.find<StudentController>().likeDanceClass(widget.liveClass.danceClassId);
                          },
                          icon: (widget.liveClass.isLiked == 0)
                              ? Icon(Icons.favorite_outline, color: Colors.red)
                              : Icon(Icons.favorite, color: Colors.red),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              size: 24,
                              Icons.location_on,
                               color: Color.fromARGB(255, 193, 72, 160),
                            ),
                          Text(" ${widget.liveClass.location}", style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                        _buildDifficultyTag(widget.liveClass.danceDifficulty), // Add the difficulty tag

                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(size: 24, Icons.calendar_month,  color: Color.fromARGB(255, 193, 72, 160)),
                                Text(widget.liveClass.date, style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(size: 24, Icons.access_time,  color: Color.fromARGB(255, 193, 72, 160),),
                                Text("12:00 PM", style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(size: 24, Icons.money,  color: Color.fromARGB(255, 193, 72, 160),),
                                Text(widget.liveClass.price.toString(), style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Get.to(InstructorDetailsPage(instructor: widget.liveClass.instructor));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(widget.liveClass.instructor.profilePicture!),
                          ),
                          SizedBox(width: 10),
                          Text("${widget.liveClass.instructor.firstName} ${widget.liveClass.instructor.lastName}", style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(widget.liveClass.description, style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
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
  }}
