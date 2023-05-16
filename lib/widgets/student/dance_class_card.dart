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
                              children: [
                                  Row(
                                    children: [
                                      Icon(size: 10, Icons.calendar_month),
                                      const SizedBox(width: 5,),
                                      Text(liveClass.date, style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                                  SizedBox(width: 10,),

                                  Row(
                                    children: [
                                      Icon(size: 10, Icons.location_on),
                                      const SizedBox(width: 5,),
                                      Text(liveClass.location, style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  )

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