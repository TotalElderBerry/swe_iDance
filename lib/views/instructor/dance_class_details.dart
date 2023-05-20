// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:i_dance/views/instructor/attendance.dart';
// import 'package:i_dance/views/instructor/student_list.dart';

// import '../../models/live_dance_class.dart';

// class DanceClassDetails extends StatelessWidget {
//   final LiveDanceClassModel liveDance;

//   DanceClassDetails({Key? key, required this.liveDance}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print("live class id ${liveDance.liveClassId} and dance class id ${liveDance.danceClassId}");
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Container(
//         height: 50,
//         margin: const EdgeInsets.all(10),
//         child: ElevatedButton(
//           onPressed: () => Get.to(AttendanceScreen(liveDance: liveDance)),
//           child: const Center(
//             child: Text('Attendance'),
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         actions: [
//           // IconButton(onPressed: (){}, icon: Icon(Icons.qr_code))
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           children: [
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: liveDance.img!.isEmpty
//                     ? SizedBox(
//                         height: 150,
//                         width: double.infinity,
//                         child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
//                       )
//                     : Image.network(
//                         liveDance.img!,
//                         fit: BoxFit.cover,
//                         height: 150,
//                         width: double.infinity,
//                       ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             Text(liveDance.danceName, style: Theme.of(context).textTheme.headline5),
//             const SizedBox(height: 25),
//             Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 Chip(
//                   avatar: const Icon(
//                     Icons.music_note,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     liveDance.danceSong,
//                     style: TextStyle(color: Colors.white, fontSize: 11),
//                   ),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 Chip(
//                   avatar: const Icon(
//                     Icons.calendar_month,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     liveDance.date,
//                     style: TextStyle(color: Colors.white, fontSize: 11),
//                   ),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 Chip(
//                   avatar: const Icon(
//                     Icons.access_time,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     '12:00 PM',
//                     style: TextStyle(color: Colors.white, fontSize: 11),
//                   ),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 25),
//             Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 Chip(
//                   avatar: const Icon(
//                     Icons.location_on,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     liveDance.location,
//                     style: TextStyle(color: Colors.white, fontSize: 11),
//                   ),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 Chip(
//                   avatar: const Icon(
//                     Icons.money,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     "${liveDance.price}",
//                     style: TextStyle(color: Colors.white, fontSize: 11),
//                   ),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.pending_outlined),
//                       iconSize: 30,
//                       onPressed: () => Get.to(StudentListScreen(
//                         initIndex: 0,
//                         liveDance: liveDance,
//                       )),
//                     ),
//                     const Text("Pending"),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.approval),
//                       iconSize: 30,
//                       onPressed: () => Get.to(StudentListScreen(
//                         initIndex: 1,
//                         liveDance: liveDance,
//                       )),
//                     ),
//                     const Text("Approved"),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             Text("Description:"),
//             const SizedBox(height: 8),
//             Text(
//               "Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/attendance.dart';
import 'package:i_dance/views/instructor/student_list.dart';

import '../../models/live_dance_class.dart';

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
      appBar: AppBar(),
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        liveDance.danceName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(width: 8),
                      _buildDifficultyTag(liveDance.danceDifficulty),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        liveDance.date,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        '12:00 PM',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        liveDance.location,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.attach_money, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        liveDance.price.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    liveDance.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AttendanceScreen(liveDance: liveDance)),
        child: Icon(Icons.assignment),
      ),
    );
  }
}
