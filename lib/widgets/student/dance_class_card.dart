import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/dance_class_details.dart';
import 'package:i_dance/views/student/instructor_details_page.dart';

import '../../models/live_dance_class.dart';

class DanceClassCard extends StatelessWidget {
  LiveDanceClassModel liveClass;
  DanceClassCard({super.key, required this.liveClass});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(DanceClassDetails(liveClass: liveClass,));
      },
      child: Container(
        width: (MediaQuery.of(context).size.width)-70,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:const  BorderRadius.all(Radius.circular(8)),
                            child:
                            (liveClass.img == "")?
                            const SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
                                ): 
                            Image.network(
                                liveClass.img!,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                            ),
                        ),
                        const SizedBox(width: 20,),
                       
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                               children: [
                                Column(
                                  children: [
                                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Live Class",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                const SizedBox(width: 10,),

                                            _buildDifficultyTag(liveClass.danceDifficulty)

                                      ],
                                    ),
                                  ],
                                ),
                                 Text(liveClass.danceName, style: Theme.of(context).textTheme.titleMedium,),
                                const SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 10,
                                          backgroundImage: 
                                          NetworkImage(liveClass.instructor.profilePicture!)
                                        ),
                                        SizedBox(width: 5,),
                                      Text("${liveClass.instructor.firstName} ${liveClass.instructor.lastName}", style: Theme.of(context).textTheme.labelSmall,),
                                  
                                    ],
                                  ),
                               ],
                             ),
                             const SizedBox(height: 5,),
                                  SizedBox(height: 10,),

                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(size: 10, Icons.calendar_month),
                                        const SizedBox(width: 2,),
                                        Text(liveClass.date, style: Theme.of(context).textTheme.labelSmall,),
                                      ],
                                    ),
                                    SizedBox(width: 2,),
                             
                                    Row(
                                      children: [
                                        Icon(size: 10, Icons.location_on),
                                        const SizedBox(width: 2,),
                                        Text(liveClass.location, style: Theme.of(context).textTheme.labelSmall,),
                                        const SizedBox(width: 2,),

                                      ],
                                    ),
                                  ],
                                ),
                              ],
                             )
                          ],
                        ),
                        Spacer(),


                      // Padding(
                      //   padding: const EdgeInsets.all(4.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //        GestureDetector(
                      //           onTap: (){
                      //             Get.to(InstructorDetailsPage());
                      //           },
                      //          child: Row(
                      //               children: [
                      //                 CircleAvatar(
                      //                     radius: 10,
                      //                     backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                      //                   ),
                      //                   SizedBox(width: 5,),
                      //                 Text("Roger Intong", style: Theme.of(context).textTheme.labelSmall,),
                                  
                      //               ],
                      //             ),
                      //        ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Run - BTS", style: Theme.of(context).textTheme.titleMedium,),
                      //           Row(
                      //             children: [
                      //               IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline,size: 12,),padding: EdgeInsets.all(8),color: Colors.red,constraints: BoxConstraints(),),
                      //               // Text("88", style: Theme.of(context).textTheme.labelSmall,),
                                
                      //             ],
                      //           )
                            
                      //         ],
                      //       ),
                      //       const Divider(),
      
                      //       Row(
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Icon(size: 10, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                      //               Text(" March 12,2023", style: Theme.of(context).textTheme.labelSmall,),
                      //             ],
                      //           ),
                      //           const SizedBox(width:10,),
                      
                      //         ],
                      //       ),
                      //       const SizedBox(height:5,),
    
                      //       Row(
                      //         children: [
                      //           Icon(size: 10, Icons.access_time,color: Theme.of(context).primaryColor,),
                      //           Text(" 12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                      //         ],
                      //       ),
                      //       const SizedBox(height:5,),
                      
                      //       Row(
                      //           children: [
                      //             Icon(size: 10, Icons.location_on,color: Theme.of(context).primaryColor,),
                      //             Text(" UC Main Campus", style: Theme.of(context).textTheme.labelSmall,),
                      //           ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //       const SizedBox(height:5,),
      
                       
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
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
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              tagIcon,
              size: 12,
              color: Colors.white,
            ),
            SizedBox(width: 2),
            Text(
              tagText,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  }
