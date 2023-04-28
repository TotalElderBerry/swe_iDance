import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/dance_class_booking.dart';

import '../../models/live_dance_class.dart';
import '../instructor/add_dance_payment_page.dart';
import 'instructor_details_page.dart';

class DanceClassDetails extends StatelessWidget {
  LiveDanceClassModel liveClass;

  DanceClassDetails({super.key, required this.liveClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Get.to(JoinDanceClassPage(liveClass: liveClass,));
          },
          child: const Center(
            child: Text('Book this Class'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32, ),
        child: SingleChildScrollView(
          child: Column(
            children: [
               ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                  fit: BoxFit.contain,
                  height: 200,
                  ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(liveClass.danceName, style: Theme.of(context).textTheme.headlineLarge,),
                    
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite, color: Colors.red,))
                      ],
                    ),
              
                      Row(
                          children: [
                            Icon(size: 24, Icons.location_on,color: Theme.of(context).primaryColor,),
                            Text(" ${liveClass.location}", style: Theme.of(context).textTheme.labelSmall,),
                          ],
                      ),
              
                      const SizedBox(height: 10,),
              
                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                              children: [
                                Row(
                                  children: [
                                    Icon(size: 24, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                    Text(liveClass.date, style: Theme.of(context).textTheme.labelSmall,),
                                  ],
                                ),
                                const SizedBox(width:15,),
              
                                Row(
                                    children: [
                                      Icon(size: 24, Icons.access_time,color: Theme.of(context).primaryColor,),
                                      Text("12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                                const SizedBox(width:15,),
              
                                  Row(
                                    children: [
                                      Icon(size: 24, Icons.money,color: Theme.of(context).primaryColor,),
                                      Text(liveClass.price.toString(), style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                        
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(),
                      SizedBox(height: 5,),
        
                       GestureDetector(
                         onTap: (){
                          Get.to(InstructorDetailsPage(instructor: liveClass.instructor,));
                         },
                         child: Row(
                          children: [
                            CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                              ),
                              SizedBox(width: 10,),
                            Text("${liveClass.instructor.firstName} ${liveClass.instructor.lastName}", style: Theme.of(context).textTheme.labelMedium,),
                                             
                          ],
                                             ),
                       ),
        
                      SizedBox(height: 20,),
        
                      Text("Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",style: Theme.of(context).textTheme.bodyMedium,),
        
                      SizedBox(height: 100,),
                      
        
                 
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