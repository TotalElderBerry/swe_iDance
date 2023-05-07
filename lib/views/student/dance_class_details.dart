import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/views/student/dance_class_booking.dart';

import '../../models/live_dance_class.dart';
import '../instructor/add_dance_payment_page.dart';
import 'instructor_details_page.dart';

import '../../utils/getDaysBetween.dart';
class DanceClassDetails extends StatefulWidget{
  LiveDanceClassModel liveClass;

  DanceClassDetails({super.key, required this.liveClass});

  @override
  State<DanceClassDetails> createState() => _DanceClassDetailsState();
}

class _DanceClassDetailsState extends State<DanceClassDetails> {
  @override
  Widget build(BuildContext context) {
    print("live class id ${widget.liveClass.liveClassId} and dance class id ${widget.liveClass.danceClassId}");

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (getDaysBetweenFromToday(widget.liveClass.date) > 0)? Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Get.to(JoinDanceClassPage(liveClass: widget.liveClass,));
          },
          child: const Center(
            child: Text('Book this Class'),
          ),
        ),
      ):Container(
         height: 50,
        margin: const EdgeInsets.all(10),
        child: null
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32, ),
        child: SingleChildScrollView(
          child: Column(
            children: [
               ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: 
                  (widget.liveClass.img == "")?
                  const SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: DecoratedBox(decoration: const BoxDecoration(color: Colors.grey)),
                                ):
                  Image.network(widget.liveClass.img!,
                  fit: BoxFit.fill,
                  height: 200,
                  width: double.infinity,
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
                        Text(widget.liveClass.danceName, style: Theme.of(context).textTheme.headlineLarge,),
                    
                        IconButton(onPressed: ()async{
                          setState(() {
                            if(widget.liveClass.isLiked == 0){
                              widget.liveClass.isLiked = 1;
                            }else{
                              widget.liveClass.isLiked = 0;
                            }
                          //  widget.liveClass.isLiked = !widget.liveClass.isLiked; 
                          });
                            await Get.find<StudentController>().likeDanceClass(widget.liveClass.danceClassId);
                        }, icon: 
                        (widget.liveClass.isLiked == 0)?
                        Icon(Icons.favorite_outline, color: Colors.red,)
                        :
                        Icon(Icons.favorite, color: Colors.red,)
                        )
                      ],
                    ),
              
                      Row(
                          children: [
                            Icon(size: 24, Icons.location_on,color: Theme.of(context).primaryColor,),
                            Text(" ${widget.liveClass.location}", style: Theme.of(context).textTheme.labelSmall,),
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
                                    Text(widget.liveClass.date, style: Theme.of(context).textTheme.labelSmall,),
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
                                      Text(widget.liveClass.price.toString(), style: Theme.of(context).textTheme.labelSmall,),
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
                          Get.to(InstructorDetailsPage(instructor: widget.liveClass.instructor,));
                         },
                         child: Row(
                          children: [
                            CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(widget.liveClass.instructor.profilePicture!),
                              ),
                              SizedBox(width: 10,),
                            Text("${widget.liveClass.instructor.firstName} ${widget.liveClass.instructor.lastName}", style: Theme.of(context).textTheme.labelMedium,),
                                             
                          ],
                                             ),
                       ),
        
                      SizedBox(height: 20,),
        
                      Text(widget.liveClass.description,style: Theme.of(context).textTheme.bodyMedium,),
        
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